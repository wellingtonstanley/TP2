require_relative 'tpEmployee'

class Profissional
  include Funcionario

  def initialize(nivel=0, **args)
    # mesmo que super(args)
    Funcionario.instance_method(:initialize).bind(self).call(args)
    @nivel = nivel
    case nivel
    when 1
      @salario = 1500.00
    when 2
      @salario = 3000.00
    when 3
      @salario = 6500.00
    when 4
      @salario = 9500.00
    when 5
      @salario = 13000.00
    else
      @salario = 18000.00
    end

  end

  def getNivel
    @nivel
  end

  def getVale_transporte
    @vale_transporte
  end

  #metodo que altera o nivel do funcionario
  def setNivel=(value)
    @nivel = value
  end

  def setVale_transporte=(value)
    @vale_transporte = value
  end

  def to_s(*args)
    puts (super + " , nivel : " + @nivel.to_s + ' ' + args.join(' '))
  end
end

class Auxiliar_Tecnico < Profissional
  def initialize(nivel=1, **args)
    super
    @vale_transporte = 350.00
  end

  def to_s
    vt = ' , vale_transporte: ' + @vale_transporte.to_s
    super vt
  end
end

 # prof = Auxiliar_Tecnico.new(nome: "teste", idade: 18)
 # prof.to_s()

class Especialista < Profissional
  def initialize(nivel=3, **args)
    super(nivel, args)
  end
end

class Diretor < Profissional
  def initialize(nivel, **args)
    super
  end

  #metodo que calcula o bonus
  def getBonus
    @bonus = super.getSalario / (2*100)
  end

end

class DirSetor < Diretor
end

class DirExecutivo < Diretor
end

class DirOperacoes < Diretor
end
