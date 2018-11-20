require_relative "Empresa.rb"

# =======  Inicialização do programa ======= #
puts " _____ ____  ____ "
puts "|_   _|  _ \\|  _ \\"
puts "  | | | | | | | | |"
puts "  | | | |_| | |_| |"
puts"  |_| |____/|____/"
puts "\n\n"
# ========================================== #

# Criação dos setores da emoresa
empresa = Empresa.new
empresa.novoSetor("financas")
empresa.novoSetor("marketing")
empresa.novoSetor("tecnologia")
empresa.novoSetor("normatividade")
empresa.novoSetor("design")

valor = -1
while valor != 0
        valor = -1
        puts "Digite a opção \n1 - Cadastro \n2 - Usuários do setor\n3 - Porcentagem de usuarios com vale-transporte  \n0 - Sair"
        valor = gets.to_i
        if valor == 1
                puts "Digite o nome do empregado: "
                nome = gets.to_s

                puts "Digite a idade: "
                idade = gets.to_i

                puts "Digite a data de nascimento (xx/xx/xxxx) : "
                data_nascimento = gets.to_s

                puts "Digite o CPF (xxxxxxxxx-xx): "
                cpf = gets.to_s

                puts "Digite o cargo (auxiliar, tecnico, profissional): "
                cargo = gets.chomp

                if (cargo == 'profissional')
                        puts "Digite a profissão:"
                        profissao = gets.chomp
                else
                        profissao = ''
                end

                puts "Digite a data de entrada na empresa (xx/xx/xxxx): "
                data_entrada = gets.to_s

                puts "Digite o setor de destino (financas, marketing, tecnologia, normatividade, design)"
                setor = gets.chomp

                empregado = Empregado.new
                empregado.novoEmpregado(nome, idade, data_nascimento, cpf, cargo, data_entrada, profissao)

                empresa.adicionarEmpregado(setor, empregado)
                puts empregado.getInfo()

        elsif (valor == 2)
                puts "Digite o nome do setor (financas, marketing, tecnologia, normatividade, design)"
                setor = gets.chomp
                empresa.imprimeEmpregados(setor)
        elsif (valor == 3)
                empresa.getEmpregadosComVale
        end

        puts "FIM DO PROGRAMA"
end
