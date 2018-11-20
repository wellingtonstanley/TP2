require_relative "Setor.rb"

class Empresa
        def initialize()
                @setores = Hash.new
        end
        def novoSetor(nome_setor)
                @setores[nome_setor] = Setor.new(nome_setor)
        end

        def getSetores()
                @setores
        end
        def adicionarEmpregado(setor,empregado)
                @setores[setor].adicionarEmpregado(empregado)
        end
        def getEmpregadosComVale()
                num_total = @setores['financas'].getNumeroEmpregados + @setores['marketing'].getNumeroEmpregados + @setores['tecnologia'].getNumeroEmpregados + @setores['normatividade'].getNumeroEmpregados + @setores['design'].getNumeroEmpregados
                num_vales = @setores['financas'].getEmpregadosComVale +  @setores['marketing'].getEmpregadosComVale +  @setores['tecnologia'].getEmpregadosComVale +  @setores['normatividade'].getEmpregadosComVale +  @setores['design'].getEmpregadosComVale
                if num_total != 0
                        total = (num_vales.to_f / num_total.to_f)*100
                        puts "Porcentagem de pessoas com vale: " + total.to_s + "%"
                else
                        puts "0%"
                end
        end
        def imprimeEmpregados(setor)
                @setores[setor].imprimeEmpregados
        end
end
