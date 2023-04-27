json.extract! produto, :id, :ean, :sku, :descricao, :fabricante, :created_at, :updated_at
json.url produto_url(produto, format: :json)
