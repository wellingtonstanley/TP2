require_relative 'tpSector'
require_relative 'tpExperts'
require_relative 'tpDB'

class Empresa
  include DB_TP2

  attr_accessor :funcionarios, :setores

  def initialize(idEmpresa=nil, nome="")
    @idEmpresa = idEmpresa
    @nome = nome
    @funcionarios = []
    @setores = []

    dset1 = ['administrador','contador','economista']
    setor1 = Financas.new(dset1, codigo: 1, nome: "financas")
    dset2 = ['administrador','contador','economista']
    setor2 = Marketing.new(dset2, codigo: 2, nome: "marketing")
    dset3 = ['engcomputacao','engsistemas','enginformacao']
    setor3 = Tecnologia.new(dset3, codigo: 3, nome: "tecnologia")
    dset4 = ['advogado','comsocial','contador']
    setor4 = Normatividade.new(dset4, codigo: 4, nome: "normatividade")
    dset5 = ['dgrafico','dmultimedia','engsocial']
    setor5 = Design.new(dset5, codigo: 5, nome: "design")

    setores << setor1 << setor2 << setor3<< setor4 << setor5
    setFuncionarios
  end

  def admitirFuncionario(funcionario)
    @funcionarios << funcionario
    DB_TP2.insertFuncionario(funcionario, @idEmpresa)
  end

  def demitirFuncionario(funcionario)
    @funcionarios.delete(funcionario)
  end

  def calcularTotalVT
    total=0
    @funcionarios.each do |funcionario|
      if [1,2].include? funcionario.getNivel
        total+=1
      end
    end
    porcentagem = total*100 / @funcionarios.size.to_f
    puts ("\nPorcentagem do total de funcionarios que percebe vale-transporte: "+ porcentagem.to_s + " %")
  end

  # accessor methods
  def getIdEmpresa
    @idEmpresa
  end

  def getNome
    @nome
  end

  # setter methods
  def setIdEmpresa=(value)
    @idEmpresa = value
  end

  def setNome=(value)
    @nome = value
  end

  def setFuncionarios(funcionarios = [])
    if funcionarios.empty?
      @funcionarios = DB_TP2.getAllFuncionariosByIdEmpresa(@idEmpresa)
    else
      @funcionarios = funcionarios
    end
  end

  def to_s
    puts ("Id: " + @idEmpresa.to_s + " Nome: " + @nome)
  end

end
