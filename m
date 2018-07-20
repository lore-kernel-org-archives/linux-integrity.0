Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:23448 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731939AbeGTT2G (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Jul 2018 15:28:06 -0400
Date: Sat, 21 Jul 2018 02:37:31 +0800
From: kbuild test robot <lkp@intel.com>
To: Udit Agarwal <udit.agarwal@nxp.com>
Cc: kbuild-all@01.org, dhowells@redhat.com, zohar@linux.vnet.ibm.com,
        jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, sahil.malhotra@nxp.com,
        Udit Agarwal <udit.agarwal@nxp.com>
Subject: Re: [PATCH 1/2] security/keys/secure_key: Adds the secure key
 support based on CAAM.
Message-ID: <201807210203.1pKSh0H0%fengguang.wu@intel.com>
References: <20180720054656.29143-1-udit.agarwal@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="/9DWx/yDrRhgMJTb"
In-Reply-To: <20180720054656.29143-1-udit.agarwal@nxp.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Udit,

I love your patch! Yet something to improve:

[auto build test ERROR on security/next]
[also build test ERROR on v4.18-rc5 next-20180720]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Udit-Agarwal/security-keys-secure_key-Adds-the-secure-key-support-based-on-CAAM/20180720-142144
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   In file included from security/keys/securekey_desc.c:8:0:
>> security/keys/securekey_desc.h:9:10: fatal error: compat.h: No such file or directory
    #include "compat.h"
             ^~~~~~~~~~
   compilation terminated.

vim +9 security/keys/securekey_desc.h

     8	
   > 9	#include "compat.h"
    10	#include "regs.h"
    11	#include "intern.h"
    12	#include "desc.h"
    13	#include "desc_constr.h"
    14	#include "jr.h"
    15	#include "error.h"
    16	#include "pdb.h"
    17	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


    [ Part 2, Application/GZIP 65 KB. ]
    [ Unable to print this part. ]
