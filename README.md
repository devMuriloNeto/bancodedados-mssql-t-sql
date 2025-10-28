# <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/microsoftsqlserver/microsoftsqlserver-plain.svg" height="40" alt="microsoftsqlserver logo"  /> Banco de dados - MSSQL / T-SQL

Este repositório apresenta um projeto prático desenvolvido em **SQL Server e T-SQL**, inspirado em cenários reais de rotina em TI. O sistema simula o controle de ativos fixos e itens comuns dentro de um ambiente corporativo.

## 📁 Estrutura do Banco de Dados

Nome do banco: `Informatica`

**Tabelas criadas:**

- `Cargos` – Define os cargos disponíveis na organização  
- `Colaboradores` – Cadastro dos profissionais  
- `Equipamentos` – Lista de equipamentos de TI com tipo e quantidade  
- `AtivosFixos` – Equipamentos com código único de identificação e status  
- `ItensAlocados` – Controle de alocação de itens comuns por colaborador  
- `AtivosAlocados` – Controle de alocação de ativos fixos por colaborador

## 🧰 Funcionalidades Desenvolvidas

- Criação do banco e tabelas com relacionamentos e restrições
- População das tabelas com dados simulados
- Atualização e controle de status dos ativos
- Criação de *views* para facilitar consultas e relatórios

## 🔍 Consultas Criadas

As seguintes *views* foram implementadas:

- `StatusAtivoFixo`: Mostra todos os ativos fixos com seus respectivos status
- `ConsultarItensAlocados`: Lista os equipamentos alocados a cada colaborador
- `ConsultarAtivosAlocados`: Mostra os ativos fixos identificados por colaborador

## 💻 Como Executar

1. Copie o conteúdo do script `.sql` fornecido neste repositório
2. Abra o SQL Server Management Studio (SSMS)
3. Execute o script por blocos (`Ctrl + F5`) para criar e popular o banco
4. Use os comandos `SELECT` para explorar as *views* e validar os dados

```sql
SELECT * FROM StatusAtivoFixo;
SELECT * FROM ConsultarItensAlocados;
SELECT * FROM ConsultarAtivosAlocados;
