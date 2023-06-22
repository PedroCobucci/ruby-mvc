class ProdutosProxy
    def initialize(acesso)
      @acesso = acesso
    end

    def getProdutos
        if @acesso != 'cliente'
            Produto.where(fabricante: @acesso)
        else
            Produto.all
        end
    end

  end