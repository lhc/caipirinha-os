# luci-app-iperf

Desenvolvimento de uma interface grafica para o Iperf3 na LuCi OpenWRT.
Atualmente estamos no "rascunho" da interface, instalação é praticamente manual, mas esta descrita abaixo


# Instalação

Estou considerando que você tenha acesso ao terminal do seu OpenWRT ou acesso via SSH.
Realizei as alterações utilizando a imagem que disponibilizamos no forum do LHC:   [Link](https://discourse.lhc.net.br/t/openwrt-tutorial-para-criar-e-configurar-o-openwrt-no-virtualbox/196).


## Instalação do Iperf3

Primeiro passo é abrir o terminal do OpenWRT, realizei esses passos via SSH, para facilitar os processos. Se caso houver alguma dificuldade para isso, nos avise, que podemos criar um passo a passo no forum do  [LHC](https://discourse.lhc.net.br).

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
    
--Agora vamos executar a instalação como comando:

    root@OpenWrt:~# opkg install iperf3-ssl

Se tudo ocorreu bem você terá um retorno parecido com esse:

    Installing iperf3-ssl (3.7-1) to root...
    Downloading http://downloads.openwrt.org/releases/19.07.4/packages/x86_64/base/iperf3-ssl_3.7-1_x86_64.ipk
    Configuring iperf3-ssl.
    root@OpenWrt:~# 

-- Agora vamos fazer um teste rápido para termos certeza que Iperf esta funcionando. Execute o comando abaixo:

    root@OpenWrt:~# iperf3 -c speedtest.iveloz.net.br
Se tudo ocorreu bem você terá um retorno parecido com esse:

    root@OpenWrt:~# iperf3 -c speedtest.iveloz.net.br
    Connecting to host speedtest.iveloz.net.br, port 5201
    [  5] local 192.168.0.105 port 60268 connected to 177.125.27.122 port 5201
    [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
    [  5]   0.00-1.00   sec  3.85 MBytes  32.3 Mbits/sec   51   15.6 KBytes       
    [  5]   1.00-2.00   sec  2.36 MBytes  19.8 Mbits/sec   14   17.0 KBytes       
    [  5]   2.00-3.00   sec  2.49 MBytes  20.9 Mbits/sec   13   22.6 KBytes       
    [  5]   3.00-4.00   sec  2.73 MBytes  22.9 Mbits/sec   49   11.3 KBytes       
    [  5]   4.00-5.00   sec  2.67 MBytes  22.4 Mbits/sec   17   21.2 KBytes       
    [  5]   5.00-6.00   sec  2.42 MBytes  20.3 Mbits/sec   21   14.1 KBytes       
    [  5]   6.00-7.00   sec  2.24 MBytes  18.8 Mbits/sec   13   25.5 KBytes       
    [  5]   7.00-8.00   sec  2.67 MBytes  22.4 Mbits/sec   23   12.7 KBytes       
    [  5]   8.00-9.00   sec  2.55 MBytes  21.4 Mbits/sec   13   15.6 KBytes       
    [  5]   9.00-10.00  sec  2.61 MBytes  21.9 Mbits/sec   31   19.8 KBytes       
    - - - - - - - - - - - - - - - - - - - - - - - - -
    [ ID] Interval           Transfer     Bitrate         Retr
    [  5]   0.00-10.00  sec  26.6 MBytes  22.3 Mbits/sec  245             sender
    [  5]   0.00-10.00  sec  26.2 MBytes  21.9 Mbits/sec                  receiver

Agora tudo esta pronto para começarmos de fato a modificar o LuCi.

## Copiando arquivos

Como citado no início, a versão atual temos que fazer instalação manual, mas logo teremos a automatização desses processos. 
Para entender melhor como é estrutura MVC da LuCi, você pode ler mais sobre [AQUI](https://github.com/openwrt/luci/wiki/ModulesHowTo).

Copie cada arquivo disponibilizados aqui para sua pasta, abaixo segue a estrutura que deve ter no final desse processo:
```
+-- /usr/lib/lua/luci/
|   +-- controller/
|   |	+-- iperf.lua
|   +-- view/
|   |	+-- iperf/
|   | 	|	+-- test.htm
+-- /etc/
|   +-- config/
|	|   +-- iperf
+-- /usr/
|   +-- share/
|   |	+-- luci/
|   |	|   +-- menu.d/
|   |	|   |	+-- luci-app-iperf.json
|   |	+-- rpcd/
|   |	|   +-- acl.d/
|   |	|   |	+-- luci-app-iperf.json
```

Copia o conteúdo do iperf.lua para `/usr/lib/lua/luci/controller/iperf.lua`

Cria a pasta iperf dentro do diretorio:  `/usr/lib/lua/luci/view/`

Comando para criar a pasta: `mkdir /usr/lib/lua/luci/view/iperf`

Copia o conteúdo do test.htm para `/usr/lib/lua/luci/view/iperf/test.htm`

Copia o conteúdo do iperf para `/etc/config/iperf`

Copia o conteúdo do luci-app-iperf.json para `/usr/share/luci/menu.d/luci-app-iperf.json`

Copia o conteúdo do luci-app-iperf.json para `/usr/share/rpcd/acl.d/luci-app-iperf.json`
