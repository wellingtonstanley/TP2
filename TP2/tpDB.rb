#!/usr/bin/ruby

require 'rubygems'
require 'sqlite3'
require_relative 'tpSector'
require_relative 'tpExperts'

module DB_TP2
  def getDB
    if @db.nil?
      @db = SQLite3::Database.new(':memory:')
    end
    @db
  end

  def closeDB
    @db.close
  end

  # metodo auxiliar que cria um funcionario a partir dos dados consultados no banco
  def self.criarFuncionarioFromDados(row)
    dados = {nome: row[0], dt_nasc: row[1], idade: row[2], cpf: row[3], idEmpresa: row[4], salario: row[5], dt_entrada: row[6], setor: row[7], cargo: row[8]}
    case row[9]
    when 1
      @empl = Auxiliar_Tecnico.new(row[9],dados)
    when 2
      @empl = Auxiliar_Tecnico.new(row[9],dados)
    when 3
      @empl = Profissional.new(row[9],dados)
    when 4
      @empl = DirSetor.new(row[9],dados)
    when 5
      @empl = DirOperacoes.new(row[9],dados)
    else 6
      @empl = DirExecutivo.new(row[9],dados)
    end
    @empl
  end

  # adiciona funcionario em determinada empresa
  def insertFuncionario(funcionario, idEmpresa)
    stmt = @db.prepare "INSERT INTO funcionario(nome,dt_nasc,idade,cpf,idEmpresa,salario,dt_entrada,setor,cargo, nivel)
                       VALUES(:nome, :dt_nasc, :idade, :cpf, :idEmpresa, :salario, :dt_entrada, :setor, :cargo, :nivel)"

    stmt.execute( :nome => funcionario.getNome, :dt_nasc => funcionario.getDt_nasc, :idade => funcionario.getIdade, :cpf => funcionario.getCpf,
                  :idEmpresa => idEmpresa, :salario => funcionario.getSalario, :dt_entrada => funcionario.getDt_entrada, :setor => funcionario.getSetor.getCodigo,
                  :cargo => funcionario.getCargo, :nivel => funcionario.getNivel )
    stmt.close
  end

  # atualiza os dados de um determinado funcionario
  def updateFuncionario(funcionario, cpf)
    stmt = @db.prepare "UPDATE funcionario Set nome=?,dt_nasc=?,idade=?,cpf=?,idEmpresa=?,salario=?,dt_entrada=?,setor=?,cargo=?, nivel=? WHERE cpf=?"
    stmt.bind_param(1,funcionario.getNome)
    stmt.bind_param(2,funcionario.getDt_nasc)
    stmt.bind_param(3,funcionario.getIdade)
    stmt.bind_param(4,funcionario.getCpf)
    stmt.bind_param(5,funcionario.getIdEmpresa)
    stmt.bind_param(6,funcionario.getSalario)
    stmt.bind_param(7,funcionario.getDt_entrada)
    stmt.bind_param(8,funcionario.getSetor.getCodigo)
    stmt.bind_param(9,funcionario.getCargo)
    stmt.bind_param(10,funcionario.getNivel)
    stmt.bind_param(11,cpf)
    stmt.execute
    stmt.close
  end

  # remove o funcionario da empresa
  def deleteFuncionario(cpfFuncionario)
    @db.execute('DELETE from funcionario WHERE cpf = ?', cpfFuncionario)
  end

  # recupera todos os funcionarios com um determinado nivel
  def getFuncionariosByNivel(nivel)
    @db.execute('select * from funcionario WHERE nivel = ?', nivel) do |row|
      puts row.join("\t") + "\n"
    end
  end

  #recupera todos os funcionarios em geral
  def getAllFuncionarios
    funcionarios = []
    @db.execute('select * from funcionario') do |row|
      funcionario = criarFuncionarioFromDados(row)
       funcionarios << funcionario
    end
    funcionarios
  end

  #recupera todos os funcionarios de uma determinada empresa
  def getAllFuncionariosByIdEmpresa(idEmpresa)
    funcionarios = []
    @db.execute('select * from funcionario WHERE idEmpresa = ?', idEmpresa) do |row|
      funcionario = criarFuncionarioFromDados(row)
      funcionarios << funcionario
    end
    funcionarios
  end

  #recupera um funcionario com o determinado id = cpf
  def getFuncionarioById(cpfFuncionario)
    @db.results_as_hash = true
    @db.execute('select * from funcionario WHERE cpf=?', cpfFuncionario ) do |row|
      @funcionario = criarFuncionarioFromDados(row)
    end
      @funcionario
  end

  # TODO: metodo tem que ser feito com nomenclatura like
  def getSetorByCargo(cargo)
    @db.execute('select * from setor WHERE cargo = ?', cargo) do |row|
      puts row.join("\t") + "\n"
    end
  end

  # seleciona todos os funcionarios de determinado setor
  def getFuncionariosBySetor(idsetor)
    @db.execute('select * from funcionario WHERE setor = ?', idsetor) do |row|
      puts row.join("\t") + "\n"
    end
  end

  #recupera determinada empresa pelo seu identificador
  def getEmpresaById(idEmpresa)
    @db.results_as_hash = true
    @db.execute('select * from empresa WHERE idEmpresa=?', idEmpresa ) do |row|
      @empresa = Empresa.new(row[0], row[1])
    end
    @empresa
  end

  #mesmo que definir como self
  module_function :getDB, :closeDB, :insertFuncionario, :updateFuncionario, :deleteFuncionario, :getFuncionariosByNivel, :getAllFuncionarios,
                  :getAllFuncionariosByIdEmpresa, :getFuncionarioById, :getSetorByCargo, :getFuncionariosBySetor, :getEmpresaById

  #utilizado para criar o banco, inicializar tabelas, configuração e popular dados
  def self.create
    begin
      db = getDB
      # db.results_as_hash = true
      db.execute "CREATE TABLE empresa (idEmpresa INT PRIMARY KEY, nome CHAR(25))"
      db.execute "CREATE TABLE setor (codigo INT PRIMARY KEY, nome CHAR(25), cargos TEXT)"
      db.execute("
         CREATE TABLE funcionario ( nome TEXT, dt_nasc TEXT, idade INT, cpf CHAR(12) PRIMARY KEY, idEmpresa INT, salario REAL, dt_entrada TEXT, setor INT, cargo TEXT
         ,nivel INT, FOREIGN KEY (idEmpresa) REFERENCES empresa(idEmpresa) ON DELETE CASCADE ON UPDATE CASCADE)"
      )

      stmt = db.prepare "INSERT INTO funcionario(nome,dt_nasc,idade,cpf,idEmpresa,salario,dt_entrada,setor,cargo, nivel)
                         VALUES(:nome, :dt_nasc, :idade, :cpf, :idEmpresa, :salario, :dt_entrada, :setor, :cargo, :nivel)"

      stmt.execute( :nome => 'joao', :dt_nasc => '18/08/2000', :idade => 18, :cpf => '02555516891', :idEmpresa => 11, :salario => 1500.00,
         :dt_entrada => '20/08/2018', :setor => 2, :cargo => 'auxiliar', :nivel => 3 )
      stmt.execute( :nome => 'pedro', :dt_nasc => '18/08/1992', :idade => 26, :cpf => '02534516891', :idEmpresa => 11, :salario => 3000.00,
         :dt_entrada => '20/08/2010', :setor => 2, :cargo => 'tecnico', :nivel => 2 )
      stmt.execute( :nome => 'jose', :dt_nasc => '12/06/1990', :idade => 28, :cpf => '02652302122', :idEmpresa => 11, :salario => 6500.00,
         :dt_entrada => '20/08/2008', :setor => 2, :cargo => 'contador', :nivel => 3 )
      stmt.execute( :nome => 'paulo', :dt_nasc => '30/03/1988', :idade => 30, :cpf => '02152302194', :idEmpresa => 11, :salario => 6500.00,
        :dt_entrada => '20/08/2006', :setor => 2, :cargo => 'administrador', :nivel => 3 )
      stmt.close

      stmt = db.prepare "INSERT INTO empresa(idEmpresa,nome) VALUES(:idEmpresa, :nome)"
      stmt.execute(:idEmpresa => 11, :nome => 'primeira')
      stmt.execute(:idEmpresa => 12, :nome => 'segunda')
      stmt.execute(:idEmpresa => 13, :nome => 'terceira')
      stmt.close

      stmt = db.prepare "INSERT INTO setor(codigo,nome,cargos) VALUES(:codigo, :nome, :cargos)"
      dset1 = ['administrador','contador','economista']
      dset2 = ['administrador','contador','economista']
      dset3 = ['engcomputacao','engsistemas','enginformacao']
      dset4 = ['advogado','comsocial','contador']
      dset5 = ['dgrafico','dmultimedia','engsocial']
      stmt.execute(codigo: 1, nome: "financas", cargos: dset1.to_s)
      stmt.execute(codigo: 2, nome: "marketing", cargos: dset2.to_s)
      stmt.execute(codigo: 3, nome: "tecnologia", cargos: dset3.to_s)
      stmt.execute(codigo: 4, nome: "normatividade", cargos: dset4.to_s)
      stmt.execute(codigo: 5, nome: "design", cargos: dset5.to_s)
      stmt.close

      count = db.get_first_value("SELECT count(*) FROM funcionario")
      puts "Funcionario - count(*): #{count}"
      db.execute('select * from funcionario') do |row|
        puts row.join("\t") + "\n"
      end
      puts "\nEmpresa "
      db.execute('select * from empresa') do |row|
        puts row.join("\t") + "\n"
      end
      puts "\nSetor "
      db.execute('select * from setor') do |row|
        puts row.join("\t") + "\n"
      end

    end
  end

end
  # DB_TP2.create
# sec = Setor.new('administrador,contador,economista', codigo: 1, nome:'financas')
# dados = {nome: 'jo', dt_nasc: '18/08/2000', idade: 18, cpf: '02555516891', idEmpresa: 12, salario: 1500, dt_entrada: '20/08/2018',
#    setor: sec, cargo: 'administrador'}
# empl = Profissional.new(1,dados)
# DB_TP2.updateFuncionario(empl, empl.getCpf)
# DB_TP2.getAllFuncionarios
  # DB_TP2.closeDB
# dados = {nome: 'joao', dt_nasc: '18/08/2000', idade: 18, cpf: '02555516891', idEmpresa: 1, salario: 1500, dt_entrada: '20/08/2018',
#    setor: sec, cargo: 'administrador'}
# FOREIGN KEY () REFERENCES all_candy ON DELETE CASCADE ON UPDATE CASCADE)
# CREATE TABLE all_candy
# (candy_num SERIAL PRIMARY KEY,
# candy_maker CHAR(25));
#
# CREATE TABLE hard_candy
# (candy_num INT,
# candy_flavor CHAR(20),
# FOREIGN KEY (candy_num) REFERENCES all_candy
# ON DELETE CASCADE ON UPDATE CASCADE
