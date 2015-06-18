class Templus
  @@nome_aplicacao = "Nome da Aplicacao"
  @@nome_empresa = "Nome da Empresa"
  @@logo = 'logo_simples.png'
  @@logo_rodape = 'raro_azul.png'
  @@logo_landpage = 'logo.png'
  @@paragrafo_login = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."

  def self.nome_aplicacao
    @@nome_aplicacao
  end

  def self.nome_empresa
    @@nome_empresa
  end

  def self.logo
    @@logo
  end
  
  def self.logo_rodape
    @@logo_rodape
  end
  
  def self.logo_landpage
    @@logo_landpage
  end
  
  def self.paragrafo_login
    @@paragrafo_login
  end

end