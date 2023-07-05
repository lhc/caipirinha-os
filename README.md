# Projeto Caipirinha
Projeto aberto e colaborativo, estamos criando customizações para o OpenWRT, uma versão do LHC. Estamos trabalhando para montar uma medidor de qualidade de conexão de internet criando um novo menu e funcionalidade no OpenWRT.
 
Grupo realiza encontro mensais para discutir sobre o projeto e suas futuras implementações.

# Encontros 
- Segunda temporada
- 20/Julho/2023 - 
- [definindo]
- 
- Primeira temporada
- 27/janeiro/2022 - [OpenWRT-Capirinha-OS](https://meet.jit.si/capirinha-os)
- 27/maio/2021 - [OpenWRT- Demandas e compilados](https://discourse.lhc.net.br/t/29-04-2021-caipirinha-os-demandas-e-compilados/280)
- 29/abril/2021 - [OpenWRT- Compilados dos eventos](https://discourse.lhc.net.br/t/29-04-2021-openwrt-compilados-dos-eventos/276)
- 25/março/2021 - [OpenWRT - Caipirinha-OS](https://discourse.lhc.net.br/t/25-03-2021-openwrt-caipirinha-os/260)
- 25/fevereiro/2021 - [OpenWRT - ingredientes para a Caipirinha-OS](https://discourse.lhc.net.br/t/25-02-2021-openwrt-ingredientes-para-a-caipirinha-os/255)
- 14/janeiro/2021 - [OpenWRT - Fazendo caipirinha](https://discourse.lhc.net.br/t/14-01-2021-openwrt-fazendo-caipirinha/242/4)

# updates
- 02/Jan/2021 - [luci-app-iperf](https://github.com/lhc/caipirinha/tree/main/luci-app-iperf) via Tiago Fidel.
- 02/Jan/2021 - [luci-app-SpeedTest](https://github.com/lhc/caipirinha/tree/main/luci-app-speedtest) via Tiago Fidel.

# Reportagem
- [08/03/2022 Chamada da RNP prevê pagar R$ 300 por mês para conexão de 8 mil escolas públicas](https://www.convergenciadigital.com.br/Inclusao-Digital/Chamada-da-RNP-preve-pagar-R%24-300-por-mes-para-conexao-de-8-mil-escolas-publicas-59637.html)

- [04/09/2020 Cybersecurity Training: Maintaining Confidentiality in a Shared Home Office Environment](https://totalsecurityadvisor.blr.com/cybersecurity/cybersecurity-training-maintaining-confidentiality-in-a-shared-home-office-environment/)
- [14/07/2020 Hackers podem atacar roteadores de internet para redirecionar sites e roubar senhas; saiba se proteger
](https://g1.globo.com/economia/tecnologia/blog/altieres-rohr/post/2020/07/14/hackers-podem-atacar-roteadores-de-internet-para-redirecionar-sites-e-roubar-senhas-saiba-se-proteger.ghtml)
- [21/06/2020 Manipulação das redes pode atingir 60 milhões de pessoas
](https://odia.ig.com.br/colunas/informe-do-dia/2020/06/5936565-manipulacao-das-redes-pode-atingir-60-milhoes-de-pessoas.html)
- [06/2019 Análise de dispositivos IoT: vulnerabilidades mais comuns e formas de encontrá‑las](https://www.welivesecurity.com/br/2019/06/11/analise-de-dispositivos-iot-vulnerabilidades-mais-comuns-e-formas-de-encontra-las/)
- [05/05/2019 Ongoing DNS Hijack Attack Hits Consumer Modems and Routers](https://www.darkreading.com/perimeter/ongoing-dns-hijack-attack-hits-consumer-modems-and-routers/d/d-id/1334355)
- [Keeping your home Wi-Fi router reasonably secure](https://freedom.press/training/blog/wifi-router-security/)
- [SIMETBox package feed for OpenWRT](https://github.com/simetnicbr/simetbox-openwrt-feed)


# Referências 
- [Conhecendo o OpenWrt](https://www.embarcados.com.br/conhecendo-o-openwrt/)
- [Por dentro do OpenWRT](https://sergioprado.org/por-dentro-do-openwrt/)
- [Analisando o firmware do meu roteador com o binwalk](https://sergioprado.org/analisando-firmware-roteador-com-binwalk/)
- [WIFI](https://hpbn.co/wifi/#from-ethernet-to-a-wireless-lan)
- [Como medir desempenhos de conectividade em redes de computadores, com Iperf3 e OpenWRT](https://cryptostratus.net/posts/openwrt/iperf3/)
# Espaço para conversas e interações
- [Discourse LHC](https://discourse.lhc.net.br/c/Item-incomum-computaC3A7C3A3o-clC3A1ssica/11)

# Participantes 
- Ronaldo Nunez
- Tiage Fidel
- Douglas Esteves
- Sicka
- Éliton
- Leandro Pereira

##
# Como preparar o contêiner de construção

A compilação é feita dentro de um contêiner docker.

Dentro deste repositório, execute:
``` bash
sudo env UID=$(id -u) GID=$(id -g) docker compose build
```

Certifique-se de inicializar os submódulos:
``` bash
git submodule update --init --recursive
```
Execute o contêiner

``` bash
sudo env UID=$(id -u) GID=$(id -g) docker compose run sindri
```

#
## Ambiente

Execute o script para preparar o ambiente (somente na primeira vez)
``` bash
./setup_build.sh
```

#
## Como compilar o firmware

Execute o contêiner:
``` bash
./build_image.sh -a caipirinha
```

## Opções avançadas:

Opcionalmente, limpe o conteúdo criado anteriormente:
``` bash
make distclean
```

Atualize os feeds:
``` bash
./scripts/feeds update -a
./scripts/feeds install -a
```

Gere o arquivo ```.config```:
``` bash
cp ../.config.caipirinha .config
make defconfig
```

Para criar uma nova configuração de diferenças
```
./scripts/diffconfig.sh > ../.config.caipirinha
```
### (Opcional) Ajustar configurações

``` bash
make menuconfig
```

### Construindo o Firmware
``` bash
make download
make -j4
```

Após a reclamação, as imagens podem ser encontradas na pasta **bin/targets/bcm27xx/bcm2710/**.
```openwrt-ath79-generic-comfast_cf-e5-squashfs-sysupgrade.bin```

### Como depurar se a compilação falhar?
``` bash
make download
make -j1 V=sc
```
Os comandos acima permitirão o detalhamento e a compilação em um único thread para obter uma visualização do erro durante a compilação.
