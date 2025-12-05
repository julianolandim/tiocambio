#!/usr/bin/env python3
"""
Script para bloquear teclado enquanto API está rodando.
Apenas Ctrl+C (SIGINT) consegue interromper.
"""
import sys
import termios
import tty
import select
import time
import os
import signal
import errno

def lock_keyboard_until_process_ends(pid):
    """
    Bloqueia o teclado descartando TODAS as teclas pressionadas
    enquanto o processo com PID especificado estiver rodando.
    Apenas Ctrl+C pode interromper.
    """
    # Salvar configuração original do terminal
    fd = sys.stdin.fileno()
    old_settings = termios.tcgetattr(fd)

    try:
        # Configurar terminal em modo raw (sem echo, sem buffer)
        tty.setraw(fd)

        while True:
            # Verificar se processo ainda está rodando
            try:
                os.kill(int(pid), 0)  # Signal 0 apenas verifica se processo existe
            except OSError as e:
                if e.errno == errno.ESRCH:  # No such process
                    break
                elif e.errno == errno.EPERM:  # Operation not permitted (processo existe mas sem permissão)
                    pass  # Processo ainda existe

            # Verificar se tem tecla pressionada
            if select.select([sys.stdin], [], [], 0.01)[0]:
                # Ler o caractere
                ch = sys.stdin.read(1)

                # Detectar Ctrl+C (ASCII 3 ou ETX)
                if ord(ch) == 3:
                    # Restaurar terminal ANTES de matar processo
                    termios.tcsetattr(fd, termios.TCSADRAIN, old_settings)

                    # Matar processo da API
                    try:
                        os.kill(int(pid), signal.SIGTERM)
                        time.sleep(0.1)
                        # Se ainda estiver vivo, forçar com SIGKILL
                        try:
                            os.kill(int(pid), 0)
                            os.kill(int(pid), signal.SIGKILL)
                        except OSError:
                            pass
                    except OSError:
                        pass

                    # Sair com exit code 130 (convenção para Ctrl+C)
                    sys.exit(130)

                # Qualquer outra tecla é descartada (não faz nada)

            # Pequeno sleep para não consumir 100% CPU
            time.sleep(0.05)

    except KeyboardInterrupt:
        # Ctrl+C via signal - restaurar terminal e matar API
        termios.tcsetattr(fd, termios.TCSADRAIN, old_settings)
        try:
            os.kill(int(pid), signal.SIGTERM)
            time.sleep(0.1)
            try:
                os.kill(int(pid), 0)
                os.kill(int(pid), signal.SIGKILL)
            except OSError:
                pass
        except OSError:
            pass
        sys.exit(130)
    finally:
        # SEMPRE restaurar configuração original do terminal
        termios.tcsetattr(fd, termios.TCSADRAIN, old_settings)

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Uso: lock_keyboard.py <PID>", file=sys.stderr)
        sys.exit(1)

    try:
        lock_keyboard_until_process_ends(sys.argv[1])
    except KeyboardInterrupt:
        # Ctrl+C pressionado - sair com código especial
        sys.exit(130)
