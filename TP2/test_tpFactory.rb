require 'test/unit'
require 'test/unit/testsuite'
require 'test/unit/ui/console/testrunner'
require_relative 'tpFactory'
require_relative 'tpSector'
require_relative 'tpExperts'
require_relative 'tpDB'

#Classe que trata os casos de teste da empresa
class Factory_Test < Test::Unit::TestCase

  #casos de teste que testa a criacao de uma empresa sem dados.
  #passa se criada
  def test_make_factory_empty
    fac = Empresa.new
    assert_not_nil(fac, 'fabrica nao criada corretamente')
  end

  #casos de teste que testa a criacao de uma empresa com os dados.
  #passa se criada e os dados preenchidos sao os esperados
  def test_make_factory
    emp = Empresa.new(1, 'tpFab')
    assert_not_nil(emp, 'fabrica nao criada corretamente')
    assert_equal(1,emp.getIdEmpresa,'id invalido')
    assert_equal('tpFab',emp.getNome,'nome invalido')
  end
end

#Classe responsavel pelos casos de teste dos setores
class Sector_Test < Test::Unit::TestCase

  #casos de teste que testa a criacao de um setor sem dados.
  #passa se criado
  def test_make_sector_empty
    sec = Setor.new
    assert_not_nil(sec, 'setor nao criado corretamente')
  end

  #casos de teste que testa a criacao de um setor com os dados.
  #passa se criada e os dados preenchidos sao os esperados
  def test_make_factory
    sec = Setor.new('a, b, c', codigo: 1234, nome: 'marketing')
    assert_not_nil(sec, 'setor nao criado corretamente')
    assert_equal(1234, sec.getCodigo, 'codigo invalido')
    assert_equal('marketing', sec.getNome, 'nome invalido')
    assert_send([["a, b, c"], :include?, sec.getCargos])
  end
end

#Classe responsavel pelos casos de teste dos funcionarios. Todos os empregados herdam do modulo funcionarios,
#incluido na classe Proficcional
class Employee_Test < Test::Unit::TestCase

  #casos de teste que testa a criacao de um funcionario sem dados.
  #passa se criado
  def test_make_employee_empty
    empl = Profissional.new
    assert_not_nil(empl, 'funcionario nao criado corretamente')
  end

  #casos de teste que testa a criacao de um funcionario com os dados.
  #passa se criada e os dados preenchidos sao os esperados
  def test_make_employ
    sec = Setor.new('administrador,contador,economista', codigo: 1, nome:'financas')
    dados = {nome: 'joao', dt_nasc: '18/08/2000', idade: 18, cpf: '02555516891', idEmpresa: 1, salario: 1500, dt_entrada: '20/08/2018',
       setor: sec, cargo: 'administrador'}
    empl = Profissional.new(1,dados)
    assert_not_nil(empl, 'funcionario nao criado corretamente')
    assert_equal('joao', empl.getNome, 'nome invalido')
    assert_equal('18/08/2000', empl.getDt_nasc, 'data de nascimento invalido')
    assert_equal(18, empl.getIdade, 'idade invalido')
    assert_equal('02555516891', empl.getCpf, 'CPF invalido')
    assert_equal(1, empl.getIdEmpresa, 'codigo empresa invalido')
    assert_equal(1500, empl.getSalario, 'salario invalido')
    assert_equal('20/08/2018', empl.getDt_entrada, 'data de entrada invalida')
    assert_equal('financas', empl.getSetor.getNome, 'setor invalido')
    assert_send([sec.getCargos, :include?, empl.getCargo])
  end
end

#Suite de testes para os casos de teste do sistema
class TS_MyTests < Test::Unit::TestSuite
  def self.suite
    suite = self.new("TP2")
    suite << Factory_Test.suite
    suite << Sector_Test.suite
    suite << Employee_Test.suite
    return suite
  end

  #mesmo que before all
  def setup
    puts "\nEMPREGADOS DA EMPRESA LOCAL - TRABALHO PARTE 1\n\n"
    DB_TP2.create
  end

  #mesmo que after all
  def teardown
    db = DB_TP2.getDB
    db.close
  end

  def run(*args)
    setup
    super
    teardown
  end

end

Test::Unit::UI::Console::TestRunner.run(TS_MyTests)

#TRABALHO 2 - IMPORTANDO DE/PARA EMPRESA ESTRANGEIRA
#caminho do trabalho que esta disponivel em https://github.com/MattLemos/TP2.git
require_relative '../../TP2Con/TP2/Trab2/src/classesG1/Empresa.rb'

#TRABALHO 2
#Classe que trata os casos de teste de transferencia entre empresa
class Factory_to_Exchange_Test < Test::Unit::TestCase
  def setup
    # Criação dos setores da empresa estrangeira
    @@empresaEst = Empresa.new
    @@empresaEst.novoSetor('financas')
    @@empresaEst.novoSetor("marketing")
    @@empresaEst.novoSetor("tecnologia")
    @@empresaEst.novoSetor("normatividade")
    @@empresaEst.novoSetor("design")
    empregado1 = Empregado.new
    empregado1.novoEmpregado('primeiro', 18, '18/08/1998', '123456789-11', 'auxiliar', '11/11/2011', 'auxiliar')
    empregado2 = Empregado.new
    empregado2.novoEmpregado('segundo', 19, '18/08/1990', '123456789-12', 'tecnico', '09/09/2011', 'tecnico')
    empregado3 = Empregado.new
    empregado3.novoEmpregado('terceiro', 20, '18/08/1988', '123456789-13', 'profissional', '11/11/2001', 'administrador')
    empregado4 = Empregado.new
    empregado4.novoEmpregado('quarto', 21, '18/08/1978', '123456789-14', 'profissional', '11/11/1991', 'advogado')
    @@empresaEst.adicionarEmpregado('financas', empregado1)
    @@empresaEst.adicionarEmpregado('financas', empregado2)
    @@empresaEst.adicionarEmpregado('marketing', empregado3)
    @@empresaEst.adicionarEmpregado('normatividade', empregado4)
    puts "\nEMPREGADOS DA EMPRESA EXTERNA\n"
    puts "SETOR FINANÇAS\n"
    @@empresaEst.imprimeEmpregados('financas')
    puts "SETOR MARKETING\n"
    @@empresaEst.imprimeEmpregados('marketing')
    puts "SETOR NORMATIVIDADE\n"
    @@empresaEst.imprimeEmpregados('normatividade')

  end
  #casos de teste que testa a transferencia de um funcionario de uma empresa para outra empresa externa.
  #passa quando o funcionario sai da empresa de origem e vai para a externa = destino
  def test_exchange_to_factory
    @funcionario = DB_TP2.getFuncionarioById('026523021-22')
    puts "\nFUNCIONARIO A SER TRANSFERIDO DA EMPRESA LOCAL PARA EXTERNA\n\n"
    puts @funcionario.to_s
    setor = DB_TP2.getSetorById(@funcionario.getSetor)
    empregado5 = Empregado.new
    case @funcionario.getNivel
    when 1
      @cargo = 'auxiliar'
    when 2
      @cargo = 'tecnico'
    else
      @cargo = 'profissional'
    end

    empregado5.novoEmpregado(@funcionario.getNome,@funcionario.getIdade,@funcionario.getDt_nasc,@funcionario.getCpf, @cargo, @funcionario.getDt_entrada,
      @funcionario.getCargo)
    @@empresaEst.adicionarEmpregado(setor, empregado5)
    puts "\nEMPREGADOS DA EMPRESA EXTERNA\n"
    puts "SETOR FINANÇAS\n"
    @@empresaEst.imprimeEmpregados('financas')
    load 'tpFactory.rb'
    DB_TP2.deleteFuncionario('026523021-22')
    puts "\nEMPREGADOS DA EMPRESA LOCAL\n"
    DB_TP2.showTable('funcionario')
  end

  # #casos de teste que testa a transferencia de um funcionario de uma empresa externa para uma empresa local.
  # #passa quando o funcionario sai da empresa externa e vai para a local = destino
  # def test_exchange_from_factory
  #   @funcionario = DB_TP2.getFuncionarioById('026523021-22')
  #   puts "\nFUNCIONARIO A SER TRANSFERIDO DA EMPRESA LOCAL PARA EXTERNA\n\n"
  #   puts @funcionario.to_s
  #   setor = DB_TP2.getSetorById(@funcionario.getSetor)
  #   empregado5 = Empregado.new
  #   case @funcionario.getNivel
  #   when 1
  #     @cargo = 'auxiliar'
  #   when 2
  #     @cargo = 'tecnico'
  #   else
  #     @cargo = 'profissional'
  #   end
  #
  #   empregado5.novoEmpregado(@funcionario.getNome,@funcionario.getIdade,@funcionario.getDt_nasc,@funcionario.getCpf, @cargo, @funcionario.getDt_entrada,
  #     @funcionario.getCargo)
  #   @@empresaEst.adicionarEmpregado(setor, empregado5)
  #   puts "\nEMPREGADOS DA EMPRESA EXTERNA\n"
  #   puts "SETOR FINANÇAS\n"
  #   @@empresaEst.imprimeEmpregados('financas')
  #   DB_TP2.deleteFuncionario('026523021-22')
  #   puts "\nEMPREGADOS DA EMPRESA LOCAL\n"
  #   DB_TP2.showTable('funcionario')
  # end

end

#Parte 2 do trabalho. Suite que testa Transferencia de empregados entre empresas.
class TS_MyTest2 < Test::Unit::TestSuite
  def self.suite
    puts "\nINICIALIZANDO... TRABALHO PARTE 2\n\n"
    suite = self.new("TP2-Factory_Exchange_Test")
    suite << Factory_to_Exchange_Test.suite
    return suite
  end

  #mesmo que before all
  def setup
    puts "\nEMPREGADOS DA EMPRESA LOCAL - TRABALHO PARTE 2\n\n"
    DB_TP2.create
  end

  #mesmo que after all
  def teardown
    db = DB_TP2.getDB
    db.close
  end

  def run(*args)
    setup
    super
    teardown
  end

  def test_make_sector_empty

    assert_not_nil(sec, 'setor nao criado corretamente')
  end
end


Test::Unit::UI::Console::TestRunner.run(TS_MyTest2)
