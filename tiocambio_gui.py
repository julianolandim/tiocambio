#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
TIO CÂMBIO - Interface Gráfica
Conversor de Moedas e Sistema de Alertas
"""

import tkinter as tk
from tkinter import ttk, messagebox, scrolledtext
import threading
import json
from datetime import datetime
import os
import sys
from version import __version__, __app_name__
from currency_api import get_rates, convert

class TioCambioGUI:
    def __init__(self, root):
        self.root = root
        self.root.title(f"💰 {__app_name__} - Conversor de Moedas v{__version__}")
        self.root.geometry("800x600")
        self.root.resizable(True, True)

        # Não precisa mais do script bash - usa API Python diretamente

        # Dicionário de moedas
        self.currencies = {
            "BRL": "🇧🇷 Real Brasileiro",
            "USD": "💵 Dólar Americano",
            "EUR": "💶 Euro",
            "GBP": "💷 Libra Esterlina",
            "JPY": "💴 Iene Japonês",
            "CNY": "🇨🇳 Yuan Chinês",
            "CHF": "🇨🇭 Franco Suíço",
            "CAD": "🇨🇦 Dólar Canadense",
            "AUD": "🇦🇺 Dólar Australiano",
            "ARS": "🇦🇷 Peso Argentino",
            "PYG": "🇵🇾 Guarani Paraguaio",
            "BTC": "₿ Bitcoin"
        }

        # Lista de processos de alerta rodando
        self.alert_processes = []

        # Configurar estilo
        self.setup_style()

        # Criar interface
        self.create_widgets()

    def setup_style(self):
        """Configura o estilo da interface"""
        style = ttk.Style()
        style.theme_use('clam')

        # Cores
        bg_color = "#f0f0f0"
        accent_color = "#4CAF50"

        style.configure("Title.TLabel", font=("Arial", 16, "bold"))
        style.configure("Subtitle.TLabel", font=("Arial", 12))
        style.configure("TButton", padding=6)
        style.configure("Accent.TButton", foreground="white", background=accent_color)

    def create_widgets(self):
        """Cria os widgets da interface"""
        # Notebook (abas)
        notebook = ttk.Notebook(self.root)
        notebook.pack(fill=tk.BOTH, expand=True, padx=10, pady=10)

        # Aba 1: Cotações
        tab_quotes = ttk.Frame(notebook)
        notebook.add(tab_quotes, text="📊 Cotações")
        self.create_quotes_tab(tab_quotes)

        # Aba 2: Conversão
        tab_convert = ttk.Frame(notebook)
        notebook.add(tab_convert, text="💱 Conversão")
        self.create_convert_tab(tab_convert)

        # Aba 3: Alertas
        tab_alerts = ttk.Frame(notebook)
        notebook.add(tab_alerts, text="🔔 Alertas")
        self.create_alerts_tab(tab_alerts)

    def create_quotes_tab(self, parent):
        """Cria a aba de cotações"""
        # Frame superior
        top_frame = ttk.Frame(parent)
        top_frame.pack(fill=tk.X, padx=10, pady=10)

        ttk.Label(top_frame, text="Selecione a moeda base:",
                 style="Subtitle.TLabel").pack(side=tk.LEFT, padx=5)

        self.quote_base_var = tk.StringVar(value="BRL")
        base_combo = ttk.Combobox(top_frame, textvariable=self.quote_base_var,
                                 values=list(self.currencies.keys()),
                                 state="readonly", width=20)
        base_combo.pack(side=tk.LEFT, padx=5)

        # Botão para buscar cotações
        ttk.Button(top_frame, text="🔄 Buscar Cotações",
                  command=self.fetch_quotes).pack(side=tk.LEFT, padx=5)

        # Área de texto com scroll
        self.quotes_text = scrolledtext.ScrolledText(parent, height=20,
                                                     font=("Courier", 10))
        self.quotes_text.pack(fill=tk.BOTH, expand=True, padx=10, pady=10)

    def create_convert_tab(self, parent):
        """Cria a aba de conversão"""
        # Frame principal
        main_frame = ttk.Frame(parent, padding=20)
        main_frame.pack(fill=tk.BOTH, expand=True)

        # Título
        ttk.Label(main_frame, text="💰 Converter Moedas",
                 style="Title.TLabel").pack(pady=10)

        # Frame de conversão
        convert_frame = ttk.Frame(main_frame)
        convert_frame.pack(pady=20)

        # Moeda de origem
        ttk.Label(convert_frame, text="De:",
                 style="Subtitle.TLabel").grid(row=0, column=0, padx=5, pady=5)
        self.convert_from_var = tk.StringVar(value="BRL")
        ttk.Combobox(convert_frame, textvariable=self.convert_from_var,
                    values=list(self.currencies.keys()),
                    state="readonly", width=20).grid(row=0, column=1, padx=5, pady=5)

        # Valor
        ttk.Label(convert_frame, text="Valor:",
                 style="Subtitle.TLabel").grid(row=1, column=0, padx=5, pady=5)
        self.convert_amount_var = tk.StringVar(value="100")
        ttk.Entry(convert_frame, textvariable=self.convert_amount_var,
                 width=22).grid(row=1, column=1, padx=5, pady=5)

        # Moeda de destino
        ttk.Label(convert_frame, text="Para:",
                 style="Subtitle.TLabel").grid(row=2, column=0, padx=5, pady=5)
        self.convert_to_var = tk.StringVar(value="USD")
        ttk.Combobox(convert_frame, textvariable=self.convert_to_var,
                    values=list(self.currencies.keys()),
                    state="readonly", width=20).grid(row=2, column=1, padx=5, pady=5)

        # Botão converter
        ttk.Button(convert_frame, text="🔄 Converter",
                  command=self.convert_currency,
                  style="Accent.TButton").grid(row=3, column=0, columnspan=2, pady=20)

        # Resultado
        self.convert_result_var = tk.StringVar(value="")
        result_label = ttk.Label(main_frame, textvariable=self.convert_result_var,
                                font=("Arial", 14, "bold"), foreground="#4CAF50")
        result_label.pack(pady=20)

    def create_alerts_tab(self, parent):
        """Cria a aba de alertas"""
        # Frame principal
        main_frame = ttk.Frame(parent, padding=20)
        main_frame.pack(fill=tk.BOTH, expand=True)

        # Título
        ttk.Label(main_frame, text="🔔 Sistema de Alertas",
                 style="Title.TLabel").pack(pady=10)

        # Frame de configuração de alerta
        alert_frame = ttk.LabelFrame(main_frame, text="Configurar Novo Alerta",
                                     padding=10)
        alert_frame.pack(fill=tk.X, pady=10)

        # Tipo de alerta
        type_frame = ttk.Frame(alert_frame)
        type_frame.pack(fill=tk.X, pady=5)

        self.alert_type_var = tk.StringVar(value="pair")
        ttk.Radiobutton(type_frame, text="Par de Moedas",
                       variable=self.alert_type_var,
                       value="pair").pack(side=tk.LEFT, padx=10)
        ttk.Radiobutton(type_frame, text="Bitcoin",
                       variable=self.alert_type_var,
                       value="btc").pack(side=tk.LEFT, padx=10)

        # Frame para par de moedas
        pair_frame = ttk.Frame(alert_frame)
        pair_frame.pack(fill=tk.X, pady=5)

        ttk.Label(pair_frame, text="De:").grid(row=0, column=0, padx=5)
        self.alert_from_var = tk.StringVar(value="USD")
        ttk.Combobox(pair_frame, textvariable=self.alert_from_var,
                    values=list(self.currencies.keys()),
                    state="readonly", width=15).grid(row=0, column=1, padx=5)

        ttk.Label(pair_frame, text="Para:").grid(row=0, column=2, padx=5)
        self.alert_to_var = tk.StringVar(value="BRL")
        ttk.Combobox(pair_frame, textvariable=self.alert_to_var,
                    values=list(self.currencies.keys()),
                    state="readonly", width=15).grid(row=0, column=3, padx=5)

        # Valores mínimo e máximo
        values_frame = ttk.Frame(alert_frame)
        values_frame.pack(fill=tk.X, pady=5)

        ttk.Label(values_frame, text="Valor Mínimo:").grid(row=0, column=0, padx=5)
        self.alert_min_var = tk.StringVar(value="5.0")
        ttk.Entry(values_frame, textvariable=self.alert_min_var,
                 width=18).grid(row=0, column=1, padx=5)

        ttk.Label(values_frame, text="Valor Máximo:").grid(row=0, column=2, padx=5)
        self.alert_max_var = tk.StringVar(value="5.5")
        ttk.Entry(values_frame, textvariable=self.alert_max_var,
                 width=18).grid(row=0, column=3, padx=5)

        # Botões
        button_frame = ttk.Frame(alert_frame)
        button_frame.pack(pady=10)

        ttk.Button(button_frame, text="▶️ Iniciar Alerta",
                  command=self.start_alert,
                  style="Accent.TButton").pack(side=tk.LEFT, padx=5)

        ttk.Button(button_frame, text="⏹️ Parar Todos os Alertas",
                  command=self.stop_all_alerts).pack(side=tk.LEFT, padx=5)

        # Lista de alertas ativos
        ttk.Label(main_frame, text="Alertas Ativos:",
                 font=("Arial", 12, "bold")).pack(pady=10)

        self.alerts_text = scrolledtext.ScrolledText(main_frame, height=10,
                                                     font=("Courier", 9))
        self.alerts_text.pack(fill=tk.BOTH, expand=True, pady=5)

    def fetch_quotes(self):
        """Busca cotações do script bash"""
        base = self.quote_base_var.get().lower()

        self.quotes_text.delete(1.0, tk.END)
        self.quotes_text.insert(tk.END, "Buscando cotações...\n")
        self.root.update()

        def run_command():
            try:
                rates = get_rates(base.upper())
                self.quotes_text.delete(1.0, tk.END)

                if rates:
                    output = f"💰 Cotações em relação a {self.currencies[base.upper()]}\n"
                    output += "=" * 60 + "\n\n"

                    for code, name in self.currencies.items():
                        if code != base.upper() and code in rates:
                            rate = rates[code]
                            output += f"{name}: {rate:.6f}\n"

                    self.quotes_text.insert(tk.END, output)
                else:
                    self.quotes_text.insert(tk.END, "Erro ao buscar cotações. Verifique sua conexão.")
            except Exception as e:
                self.quotes_text.delete(1.0, tk.END)
                self.quotes_text.insert(tk.END, f"Erro ao buscar cotações: {str(e)}")

        # Executar em thread separada
        threading.Thread(target=run_command, daemon=True).start()

    def convert_currency(self):
        """Converte valores entre moedas"""
        from_curr = self.convert_from_var.get().lower()
        to_curr = self.convert_to_var.get().lower()
        amount = self.convert_amount_var.get()

        # Validar valor
        try:
            float(amount)
        except ValueError:
            messagebox.showerror("Erro", "Por favor, insira um valor numérico válido.")
            return

        self.convert_result_var.set("Convertendo...")
        self.root.update()

        def run_command():
            try:
                amount_float = float(amount)
                result = convert(amount_float, from_curr.upper(), to_curr.upper())

                if result is not None:
                    # Formatar resultado
                    from_name = self.currencies.get(from_curr.upper(), from_curr.upper())
                    to_name = self.currencies.get(to_curr.upper(), to_curr.upper())
                    output = f"{amount_float:.2f} {from_name} = {result:.2f} {to_name}"
                    self.convert_result_var.set(output)
                else:
                    self.convert_result_var.set("Erro ao converter. Verifique sua conexão.")
            except Exception as e:
                self.convert_result_var.set(f"Erro: {str(e)}")

        # Executar em thread separada
        threading.Thread(target=run_command, daemon=True).start()

    def start_alert(self):
        """Inicia um alerta"""
        alert_type = self.alert_type_var.get()

        try:
            min_val = float(self.alert_min_var.get())
            max_val = float(self.alert_max_var.get())

            if min_val >= max_val:
                messagebox.showerror("Erro", "O valor mínimo deve ser menor que o máximo.")
                return
        except ValueError:
            messagebox.showerror("Erro", "Por favor, insira valores numéricos válidos.")
            return

        if alert_type == "btc":
            # Alerta de Bitcoin
            currency = self.alert_to_var.get().lower()
            cmd = [self.script_path, "--btc-alert", currency,
                   str(min_val), str(max_val)]
            alert_desc = f"Bitcoin → {self.alert_to_var.get()} ({min_val} - {max_val})"
        else:
            # Alerta de par de moedas
            from_curr = self.alert_from_var.get().lower()
            to_curr = self.alert_to_var.get().lower()
            cmd = [self.script_path, "--alert", from_curr, to_curr,
                   str(min_val), str(max_val)]
            alert_desc = f"{self.alert_from_var.get()} → {self.alert_to_var.get()} ({min_val} - {max_val})"

        # Iniciar processo em background
        try:
            process = subprocess.Popen(
                cmd,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                text=True
            )

            self.alert_processes.append({
                'process': process,
                'description': alert_desc,
                'started': datetime.now()
            })

            self.update_alerts_list()

            # Iniciar thread para ler output
            threading.Thread(
                target=self.read_alert_output,
                args=(process, alert_desc),
                daemon=True
            ).start()

            messagebox.showinfo("Sucesso", f"Alerta iniciado:\n{alert_desc}")

        except Exception as e:
            messagebox.showerror("Erro", f"Erro ao iniciar alerta: {str(e)}")

    def read_alert_output(self, process, description):
        """Lê o output de um alerta em execução"""
        try:
            for line in process.stdout:
                timestamp = datetime.now().strftime("%H:%M:%S")
                self.alerts_text.insert(tk.END, f"[{timestamp}] {description}: {line}")
                self.alerts_text.see(tk.END)
                self.root.update()
        except Exception as e:
            pass

    def stop_all_alerts(self):
        """Para todos os alertas ativos"""
        if not self.alert_processes:
            messagebox.showinfo("Info", "Nenhum alerta ativo.")
            return

        for alert in self.alert_processes:
            try:
                alert['process'].terminate()
            except:
                pass

        self.alert_processes.clear()
        self.update_alerts_list()
        self.alerts_text.delete(1.0, tk.END)
        messagebox.showinfo("Sucesso", "Todos os alertas foram parados.")

    def update_alerts_list(self):
        """Atualiza a lista de alertas ativos"""
        # Remover processos finalizados
        self.alert_processes = [
            a for a in self.alert_processes
            if a['process'].poll() is None
        ]

def main():
    root = tk.Tk()
    app = TioCambioGUI(root)
    root.mainloop()

if __name__ == "__main__":
    main()
