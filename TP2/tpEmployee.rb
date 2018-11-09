module Funcionario

  def initialize(nome:"", dt_nasc:"", idade:nil, cpf:"", idEmpresa:nil, salario:nil, dt_entrada:"", setor:nil, cargo:"")
    @nome = nome
    @dt_nasc = dt_nasc
    @idade = idade
    @cpf = cpf
    @idEmpresa = idEmpresa
    @salario = salario
    @dt_entrada = dt_entrada
    @setor = setor
    @cargo = cargo
  end

  def getNome
    @nome
  end

  def getDt_nasc
    @dt_nasc
  end

  def getIdade
    @idade
  end

  def getCpf
    @cpf
  end

  # accessor methods
  def getIdEmpresa
    @idEmpresa
  end

  def getSalario
    @salario
  end

  def getDt_entrada
    @dt_entrada
  end

  def getSetor
    @setor
  end

  def getCargo
    @cargo
  end

  def setNome=(value)
    @nome = value
  end

  def setDt_nasc=(value)
    @dt_nasc = value
  end

  def setIdade=(value)
    @idade = value
  end

  def setCpf=(value)
    @cpf = value
  end

  # accessor methods
  def setIdEmpresa=(value)
    @idEmpresa = value
  end

  def setSalario=(value)
    @salario = value
  end

  def setDt_entrada=(value)
    @dt_entrada = value
  end

  def setSetor=(value)
    @setor = value
  end

  def setCargo=(value)
    @cargo = value
  end

  def to_s(*args)
    "Nome: " + @nome + ", data_nasc: " + @dt_nasc + ", idade: " + @idade.to_s + ", cpf: " + @cpf + ", idEmpresa: " + @idEmpresa.to_s + ", salario: " +
      @salario.to_s + ", data_entrada: " + @dt_entrada + ", setor: " + @setor.to_s + ", cargo: " + @cargo
  end
end

#emp = Funcionario.new("primeiro")
