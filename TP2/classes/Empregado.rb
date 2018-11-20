require "colorize"

class Empregado
        def initialize()
                @info = Hash.new
        end

        # Retorna as informações do usuário em um Hash
        def getInfo()
                @info
        end

        # Cria um novo empregado usando as funções de set e validação abaixo
        def novoEmpregado(nome, idade, data_nascimento, cpf, cargo, data_entrada, profissao)
                begin
                        self.setNome(nome)
                        self.setIdade(idade)
                        self.setDataNascimento(data_nascimento)
                        self.setCPF(cpf)
                        self.setCargo(cargo)
                        self.setValeTransporte(cargo)
                        self.setDataEntrada(data_entrada)
                        self.setProfissao(profissao)
                rescue (RuntimeError) => e
                        puts e.message.red
                        @info = {}
                end
        end

# ======== Funções de Setup ========= #

        def setNome(nome)
                @info['nome'] = nome
        end
        def setIdade(idade)
                if(idade > 0 && idade <= 100)
                        @info['idade'] = idade
                else
                        raise "Idade invalida"
                end
        end
        def setDataNascimento(data_nascimento)
                begin
                        if(validateData(data_nascimento))
                                @info['data_nascimento'] = data_nascimento
                        end
                end
        end

        def setCPF(cpf)
                begin
                        if(validateCPF(cpf))
                                @info['cpf'] = cpf
                        end
                end
        end

        def setID(id)
                if(id.length != 4)
                        raise "ID possui tamanho invalido"
                end
                @info['id'] = id
        end

        def setCargo(cargo)
                begin
                        if(validateCargo(cargo))
                                @info['cargo'] = cargo
                        end
                end
        end

        def setDataEntrada(data_entrada)
                begin
                        if(validateData(data_entrada))
                                @info['data_entrada'] = data_entrada
                        end
                end
        end

        def setProfissao(profissao)
                begin
                        if(validateProfissao(profissao))
                                @info['profissao'] = profissao
                        end
                end
        end

        def setSetor(setor)
                begin
                        if(validateSetor(setor))
                                @info['setor'] = setor
                        end
                end
        end

        def setSalario()
                salarios = Hash[
                        [
                                ["auxiliar",1500],
                                ["tecnico",3000],
                                ["profissional",6500],
                                ["diretor_setor",9500],
                                ["diretor_operacoes",13000],
                                ["diretor_executivo",18000]
                        ]
                ]
                cargo = self.getInfo()['cargo']
                @info['salario'] = salarios[cargo]
        end

        def setValeTransporte(cargo)
                if(cargo == 'auxiliar' || cargo == 'tecnico')
                        @info['vale_transporte'] = 350
                else
                        @info['vale_transporte'] = 0
                end
        end

# =========  Funções de Validação ========= #

        # Verifica se a data tem o formato correto usando regex
        def validateData(data)
                if(/([0][1-9]|[1-2][0-9]|[3][0-1])\/([0][0-9]|[1][0-2])\/[0-9]{4}/.match(data) != nil)
                        return true
                else
                        raise "Data invalida"
                end
        end

        # Valida o CPF usando regex
        def validateCPF(cpf)
                if(/^[0-9]{9}-[0-9]{2}$/.match(cpf) != nil)
                        return true
                else
                        raise "CPF invalido"
                end
        end

        # Valida o cargo verificando que ele existe no vetor
        def validateCargo(cargo)
                cargos = Array['auxiliar','tecnico','profissional','diretor_setor','diretor_executivo','diretor_de_operacoes']
                if(!cargos.include? cargo)
                        raise "Cargo invalido"
                elsif(cargo == 'diretor_setor' && self.getInfo()['cargo'] != 'profissional')
                        raise "Cargo de profissional eh necessario para ser diretor de setor"
                elsif((cargo == 'diretor_operacoes' || cargo == 'diretor_executivo') && self.getInfo()['cargo'] != 'profissional')
                        raise "Cargo de profissional eh necessario para ser diretor"
                end
                # puts "true"
                return true
        end

        # Valida a profissão verificando que ela existe no vetor
        def validateProfissao(profissao)
                profissoes = Array['administrador','contador','economista','comunicador','mercadologo','engenheiro_de_computacao','engenheiro_de_sistemas','engenheiro_de_informacao','engenheiro_social','advogado','comunicador','designer_grafico','designer_multimidia']
                if(self.getInfo['cargo'] == 'profissional')
                        if(!profissoes.include? profissao)
                                raise "Profissao invalida ("+ profissao + ")"
                        end
                end
                return true
        end

        # Valida o setor verificando que ele existe no hash
        def validateSetor(setor)
                setores = {
                                'financas' => ['administrador','contador','economista'],
                                'marketing' => ['comunicador','administrador','mercadologo'],
                                'tecnologia' => ['engenheiro_de_computacao', 'engenheiro_de_sistemas', 'engenheiro_de_informacao'],
                                'normatividade' => ['advogado','comunicador','contador'],
                                'design' => ['designer_grafico','designer_multimidia', 'engenheiro_social']

                }
                info = self.getInfo()
                cargo = info['cargo']
                profissao = info['profissao']
                if (!setores.include? setor)
                        raise "Setor invalido"
                elsif (cargo == 'profissional')
                        if(!setores[setor].include? profissao)
                                raise "Nao possui os requisitos do setor"
                        end
                end
                return true
        end
end
