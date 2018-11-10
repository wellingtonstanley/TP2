
require_relative 'tpFactory'

# =======  Apresentação ======= #
puts " _____ ____  ____ "
puts "|_   _|    |\\   |  \\"
puts "  | | |  __| ___|"
puts "  | | | |   |"
puts"  |_| |_|   |___"
puts "\n\n"
# ========================================== #

DB_TP2.getDB
DB_TP2.create
empresa = DB_TP2.getEmpresaById(11)
puts "\nEmpresa Criada \n"
empresa.to_s

sair = -1
while sair != 0
        sair = -1
        puts "Menu \n1 - Cadastro \n2 - Porcentagem do total de usuarios com vale-transporte  \n0 - Sair"
        sair = gets.to_i
        if sair == 1
                puts "Digite o nome do empregado: "
                nome = gets.chomp

                puts "Digite a idade: "
                idade = gets.chomp

                puts "Digite a data de nascimento (xx/xx/xxxx) : "
                data_nascimento = gets.chomp

                puts "Digite o CPF (xxxxxxxxx-xx): "
                cpf = gets.chomp

                puts "Digite o cargo (auxiliar, tecnico, profissional): "
                cargo = gets.chomp

                puts "Digite a data de entrada na empresa (xx/xx/xxxx): "
                data_entrada = gets.chomp

                puts "Digite o numero do setor (1- financas, 2- marketing, 3- tecnologia, 4- normatividade, 5- design)"
                setor = gets.chomp

                puts "Digite o cargo (1- auxiliar , 2- técnico, 3- especialista, 4- diretor de setor, 5- diretor de operações, 6- diretor executivo)"
                nivel = gets.chomp.to_i

                dados = {nome: nome, dt_nasc: data_nascimento, idade: idade, cpf: cpf, idEmpresa: empresa.getIdEmpresa, dt_entrada: data_entrada,
                    setor: setor, cargo: cargo}

                puts dados

                case nivel
                when 1
                  @empregado = Auxiliar_Tecnico.new(nivel,dados)
                when 2
                  @empregado = Auxiliar_Tecnico.new(nivel,dados)
                when 3
                  @empregado = Profissional.new(nivel,dados)
                when 4
                  @empregado = DirSetor.new(nivel,dados)
                when 5
                  @empregado = DirOperacoes.new(nivel,dados)
                else
                  @empregado = DirExecutivo.new(nivel,dados)
                end

                empresa.admitirFuncionario(@empregado)
                puts @empregado.to_s

        elsif (sair == 2)
          empresa.calcularTotalVT
        end

        puts "FIM DO PROGRAMA"
end
DB_TP2.showTable("funcionario")
DB_TP2.closeDB
