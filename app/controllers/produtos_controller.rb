require 'faraday'
require 'json'

class ProdutosController < ApplicationController

  

  before_action :set_produto, only: %i[ show edit update destroy ]
  before_action :make_get_request, only: %i[ index edit update destroy show ]

  # GET /produtos or /produtos.json
  def index
    print($teste)
    @produtos = Produto.all
  end

  # GET /produtos/1 or /produtos/1.json
  def show
  end

  # GET /produtos/new
  def new
    print($teste)
    @produto = Produto.new
  end

  # GET /produtos/1/edit
  def edit
  end

  # POST /produtos or /produtos.json
  def create
    @produto = Produto.new(produto_params)

    respond_to do |format|
      if @produto.save
        format.html { redirect_to produto_url(@produto), notice: "Produto was successfully created." }
        format.json { render :show, status: :created, location: @produto }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @produto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /produtos/1 or /produtos/1.json
  def update
    respond_to do |format|
      if @produto.update(produto_params)
        format.html { redirect_to produto_url(@produto), notice: "Produto was successfully updated." }
        format.json { render :show, status: :ok, location: @produto }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @produto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /produtos/1 or /produtos/1.json
  def destroy
    @produto.destroy

    respond_to do |format|
      format.html { redirect_to produtos_url, notice: "Produto was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_produto
      @produto = Produto.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def produto_params
      params.require(:produto).permit(:ean, :sku, :descricao, :fabricante)
    end

    def make_get_request
      begin
        conn = Faraday.new(url: 'http://localhost:3000')
      
        response = conn.get do |req|
          req.headers['Authorization'] = Rails.application.credentials.token
          req.url 'http://localhost:3000/api/auth/validate_token'
          req.params['uid'] = $uid
          req.params['client'] = $client
          req.params['access-token'] = $access_token

        end
      
        json_body = JSON.parse(response.body)
        success = json_body['success']

        print("\n" , "success: " , success , "\n")

        unless success == true
          redirect_to auth_sign_in_path
        end

      rescue => exception

        print("erro: ", exception)

      end
    end
end
