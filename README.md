# Projeto Caipirinha
Projeto aberto e colaborativo, estamos criando customizações para o OpenWRT, uma versão do LHC. Estamos trabalhando para montar uma medidor de qualidade de conexão de internet criando um novo menu e funcionalidade no OpenWRT.
![Caipirinha-OS](assets/Login.png)
##
# Como preparar o ambiente de build

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
./build_image.sh -a chirpstackos_rpi4
```
Esse comando irá buildar a versão do Caipirinha-OS para a raspberry pi 4 com o chirpstack (LoRaWan)

## Opções avançadas:

Os comandos a seguir devem ser executados dentro do contêiner, especificamente na
pasta `openwrt`:

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
- Tiago Serrano
