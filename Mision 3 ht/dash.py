import pandas as pd
import numpy as np
import dash

#import dash_core_components as dcc
from dash import dcc
#import dash_html_components as html
from dash import html

from dash.dependencies import Input, Output
import plotly.graph_objects as go

# Crear un DataFrame con datos ficticios de transacciones financieras
np.random.seed(42)
num_transactions = 50
clientes = ['Cliente{}'.format(i) for i in range(1, 11)]
data = {
    'Cliente Origen': np.random.choice(clientes, num_transactions),
    'Cliente Destino': np.random.choice(clientes, num_transactions),
    'Monto': np.random.randint(100, 10000, num_transactions)
}

df = pd.DataFrame(data)

# Inicializar la aplicación Dash
app = dash.Dash(__name__)

# Definir el layout de la aplicación
app.layout = html.Div([
    html.H1("Visualización de Datos de Transacciones Financieras de Clientes Bancarios"),
    dcc.Dropdown(
        id='dropdown',
        options=[{'label': client, 'value': client} for client in clientes],
        value=clientes[0]
    ),
    dcc.Graph(id='graph')
])

# Callback para actualizar el gráfico de barras
@app.callback(
    Output('graph', 'figure'),
    [Input('dropdown', 'value')]
)
def update_graph(selected_client):
    # Filtrar el DataFrame para obtener las transacciones relacionadas con el cliente seleccionado
    filtered_df = df[(df['Cliente Origen'] == selected_client) | (df['Cliente Destino'] == selected_client)]

    # Agrupar por cliente y sumar los montos
    transactions = filtered_df.groupby(['Cliente Origen', 'Cliente Destino']).agg({'Monto': 'sum'}).reset_index()

    # Crear el gráfico de barras horizontales
    fig = go.Figure()
    fig.add_trace(go.Bar(
        y=transactions['Cliente Destino'],
        x=transactions['Monto'],
        orientation='h',
        marker=dict(color='skyblue'),
        name='Transacciones'
    ))

    fig.update_layout(title='Transacciones Financieras de {}'.format(selected_client), yaxis_title='Cliente Destino', xaxis_title='Monto')

    return fig

# Ejecutar la aplicación
if __name__ == '__main__':
    app.run_server(debug=True)