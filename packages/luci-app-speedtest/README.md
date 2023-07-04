# luci-app-SpeedTest

Desenvolvimento de uma interface grafica para o SpeedTest-CLI na LuCi OpenWRT.
Atualmente estamos no "rascunho" da interface, instalação é praticamente manual, mas esta descrita abaixo


# Instalação

Estou considerando que você tenha acesso ao terminal do seu OpenWRT ou acesso via SSH.
Realizei as alterações utilizando a imagem que disponibilizamos no forum do LHC:   [Link](https://discourse.lhc.net.br/t/openwrt-tutorial-para-criar-e-configurar-o-openwrt-no-virtualbox/196).


## Instalação do SpeedTest

Primeiro passo é abrir o terminal do OpenWRT, realizei esses passos via SSH, para facilitar os processos. Se caso houver alguma dificuldade para isso, nos avise, que podemos criar um passo a passo no forum do  [LHC](https://discourse.lhc.net.br/c/Item-incomum-computaC3A7C3A3o-clC3A1ssica/11).

-- Com o terminal aberto execute o **opkg update** para que seja atualizado as origens dos pacotes de instalação do OpenWRT.
Abaixo segue o exemplo do retorno esperado desse comando:

    root@OpenWrt:~# opkg update
    Downloading http://downloads.openwrt.org/releases/19.07.4/targets/x86/64/packages/Packages.gz
    Updated list of available packages in /var/opkg-lists/openwrt_core
    Downloading http://downloads.openwrt.org/releases/19.07.4/targets/x86/64/packages/Packages.sig
    Signature check passed.
    Downloading http://downloads.openwrt.org/releases/19.07.4/packages/x86_64/base/Packages.gz
    Updated list of available packages in /var/opkg-lists/openwrt_base
    Downloading http://downloads.openwrt.org/releases/19.07.4/packages/x86_64/base/Packages.sig
    Signature check passed.
    Downloading http://downloads.openwrt.org/releases/19.07.4/packages/x86_64/luci/Packages.gz
    Updated list of available packages in /var/opkg-lists/openwrt_luci
    Downloading http://downloads.openwrt.org/releases/19.07.4/packages/x86_64/luci/Packages.sig
    Signature check passed.
    Downloading http://downloads.openwrt.org/releases/19.07.4/packages/x86_64/packages/Packages.gz
    Updated list of available packages in /var/opkg-lists/openwrt_packages
    Downloading http://downloads.openwrt.org/releases/19.07.4/packages/x86_64/packages/Packages.sig
    Signature check passed.
    Downloading http://downloads.openwrt.org/releases/19.07.4/packages/x86_64/routing/Packages.gz
    Updated list of available packages in /var/opkg-lists/openwrt_routing
    Downloading http://downloads.openwrt.org/releases/19.07.4/packages/x86_64/routing/Packages.sig
    Signature check passed.
    Downloading http://downloads.openwrt.org/releases/19.07.4/packages/x86_64/telephony/Packages.gz
    Updated list of available packages in /var/opkg-lists/openwrt_telephony
    Downloading http://downloads.openwrt.org/releases/19.07.4/packages/x86_64/telephony/Packages.sig
    Signature check passed.
    
--Agora vamos executar a instalação as dependências do SpeedTest que é somente o  python:

    root@OpenWrt:~# opkg install python-pip
    
   --Agora vamos executar a instalação do SpeedTest

    root@OpenWrt:~# pip install speedtest-cli

-- Agora vamos fazer um teste rápido para termos certeza que SpeedTest esta funcionando. Execute o comando abaixo:

    root@OpenWrt:~# speedtest
Se tudo ocorreu bem você terá um retorno parecido com esse:

    root@OpenWrt:~# speedtest
    Retrieving speedtest.net configuration...
    Testing from Network Telecomunicacoes Ltda (187.19.88.138)...
    Retrieving speedtest.net server list...
    Selecting best server based on ping...
    Hosted by AliancaNet (Guarulhos) [127.63 km]: 9.269 ms
    Testing download speed................................................................................
    Download: 37.29 Mbit/s
    Testing upload speed................................................................................................
    Upload: 21.73 Mbit/s


Agora tudo esta pronto para começarmos de fato a modificar o LuCi.

## Copiando arquivos

Como citado no início, a versão atual temos que fazer instalação manual, mas logo teremos a automatização desses processos. 
Para entender melhor como é estrutura MVC da LuCi, você pode ler mais sobre [AQUI](https://github.com/openwrt/luci/wiki/ModulesHowTo).

Copie cada arquivo disponibilizados aqui para sua pasta, abaixo segue a estrutura que deve ter no final desse processo:
```
+-- /usr/lib/lua/luci/
|   +-- controller/
|   |	+-- speedtest.lua
|   +-- view/
|   |	+-- speedtest/
|   | 	|	+-- test.htm

```

Copia o conteúdo do speedtest.lua para `/usr/lib/lua/luci/controller/speedtest.lua`

Cria a pasta speedtest dentro do diretorio:  `/usr/lib/lua/luci/view/`
Comando para criar a pasta: `mkdir /usr/lib/lua/luci/view/speedtest`
Copia o conteúdo do test.htm para /usr/lib/lua/luci/view/iperf/test.htm
https://github.com/sivel/speedtest-cli

