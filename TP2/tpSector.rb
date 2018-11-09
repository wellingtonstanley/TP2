class Setor

  def initialize(cargos="", codigo: nil, nome: "")
    @codigo = codigo
    @nome = nome
    @cargos = cargos
    @funcionarios = []
  end

  # accessor methods
  def getCodigo
    @codigo
  end

  def getNome
    @nome
  end

  def getCargos
    @cargos
  end

  # setter methods
  def setCodigo=(value)
    @codigo = value
  end

  def setNome=(value)
    @nome = value
  end

  def setCargos(value)
    @cargos = value
  end

  def to_s
    puts ("Codigo: " + @codigo.to_s + ", Nome: " + @nome + ", Cargos: " + @cargos.to_s)
  end

end
t = [codigo: 1, nome: "nome"]
a = ['financas','teste']
setor = Setor.new(a, codigo: 1, nome: "nome")
# puts(setor.getCargos)

class Financas < Setor
end

class Marketing < Setor
end

class Tecnologia < Setor
end

class Normatividade < Setor
end

class Design < Setor
end
#sec = Setor.new(1,'teste','a','b','c')
