require "colorize"
require_relative "Empregado.rb"

class Setor
        def initialize(nome)
                @nome = nome
                @empregados = Array.new
        end

        def getNome()
                @nome
        end
        def getEmpregado(nome)
                i = 0
                empregado = @empregados[i]
                if (empregado.getInfo()['nome'] == nome)
                        return empregado
                else
                        while i < @empregados.size do
                                empregado = @empregados[i]
                                if(empregado.getInfo()['nome'] == nome)
                                        return empregado
                                end
                                i = i + 1
                        end
                end
                raise "Empregado nao encontrado"
        end

        # Retorna todos os empregados do setor com vale transporte
        def getEmpregadosComVale()
                num_vales = 0
                @empregados.each { |empregado|
                        if (empregado.getInfo()['vale_transporte'] != 0)
                                num_vales = num_vales + 1
                        end
                }
                return num_vales
        end

        # Imprime os empregados do setor
        def imprimeEmpregados()
                @empregados.each { |empregado|
                        info = empregado.getInfo
                        puts "\n===========================\n"
                        puts "Nome: " + info['nome'].to_s
                        puts "Idade: " + info['idade'].to_s
                        puts "Data de nascimento: " + info['data_nascimento'].to_s
                        puts "CPF: " + info['cpf'].to_s
                        puts "Data de entrada: " + info['data_entrada'].to_s
                        puts "Salario:" + info['salario'].to_s
                        puts "\n===========================\n"
                 }
        end

        def getNumeroEmpregados()
                @empregados.length
        end
        # Adiciona um novo empregado ao setor
        def adicionarEmpregado(empregado)
                begin
                        empregado.setSetor(@nome)
                        @empregados.push(empregado)
                rescue (RuntimeError) => e
                        raise e.message.red
                end
        end



        # Promove um funcionário profissional a diretor de setor
        def promoverDiretorDeSetor(nome_empregado)
                begin
                        i = 0
                        if (@empregados[i].getInfo()['nome'] == nome_empregado)
                                @empregados[i].setCargo('diretor_setor')
                                return true
                        end
                        while (i < @empregados.size)
                                if(@empregados[i].getInfo()['nome'] == nome_empregado)
                                        @empregados[i].setCargo('diretor_setor')
                                        break
                                end
                                i += 1
                        end
                rescue(RuntimeError) => e
                        raise e.message
                end
                # raise "Funcionário não encontrado ou não possui os requisitos"
        end

end
