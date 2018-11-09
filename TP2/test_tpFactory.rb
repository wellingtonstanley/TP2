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
    DB_TP2.create
  end

  #mesmo que after all
  def teardown
    db = DB_TP2.getDB
    db.close
    # begin
    #   puts "\nDigite 1 para sair \n"
    #   sair = gets.chomp.to_i
    #   if(sair == 1)
    #     db.close
    #   end
    # end until sair == 1
  end

  def run(*args)
    setup
    super
    teardown
  end

end


class DB_Test < Test::Unit::TestCase
  # def setup end
  # def teardown end

  def test_make_sector_empty

    assert_not_nil(sec, 'setor nao criado corretamente')
  end
end

class DB_MyTests
  def self.suite
    suite = Test::Unit::TestSuite.new('DB-TP2')

    return suite
  end
end
Test::Unit::UI::Console::TestRunner.run(TS_MyTests)

#Test::Unit::UI::Console::TestRunner.run(DB_MyTests)
