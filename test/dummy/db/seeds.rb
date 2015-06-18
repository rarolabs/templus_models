#Criação de usuario root RaroLabs
u = Usuario.find_by(email: "admin@rarolabs.com.br", root: true)
u ||= Usuario.create(nome: "RaroLabs", email: "admin@rarolabs.com.br", root: true, password: "rarolabs", password_confirmation: "rarolabs")