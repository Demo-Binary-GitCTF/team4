###############################################################################
# Git-based CTF
###############################################################################
#
# Author: SeongIl Wi <seongil.wi@kaist.ac.kr>
#         Jaeseung Choi <jschoi17@kaist.ac.kr>
#         Sang Kil Cha <sangkilc@kaist.ac.kr>
#
# Copyright (c) 2018 SoftSec Lab. KAIST
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.

FROM i386/debian:latest
# ======================================
# Install your package here
RUN sed -i 's/deb.debian.org/ftp.daumkakao.com/g' /etc/apt/sources.list
RUN sed -i 's/archive.ubuntu.com/ftp.daumkakao.com/g' /etc/apt/sources.list
RUN apt-get update
RUN apt-get upgrade
RUN apt-get install -y xinetd sudo
# ======================================

RUN adduser retret

COPY flag /var/ctf/flag
COPY retret /service/retret

RUN chown root:retret /var/ctf/flag /service/retret
RUN chmod 0550 /service/retret
RUN chmod 0440 /var/ctf/flag

# ======================================
# Execute service
COPY retret_service_conf /etc/xinetd.d
RUN echo "retret_service_conf 4000/tcp" >> /etc/services
RUN service xinetd restart
ENTRYPOINT ["xinetd", "-dontfork"]
# ======================================
