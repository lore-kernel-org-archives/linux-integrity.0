Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga18.intel.com ([134.134.136.126]:55421 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934958AbeFLCxs (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Jun 2018 22:53:48 -0400
Date: Tue, 12 Jun 2018 10:53:25 +0800
From: kbuild test robot <lkp@intel.com>
To: Tadeusz Struk <tadeusz.struk@intel.com>
Cc: kbuild-all@01.org, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        linux-integrity@vger.kernel.org, tadeusz.struk@intel.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] tpm: add support for nonblocking operation
Message-ID: <201806120803.W0vjfLEH%fengguang.wu@intel.com>
References: <152876282414.19591.7972634639749417028.stgit@tstruk-mobl1.jf.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="OXfL5xGRrasGEqWY"
In-Reply-To: <152876282414.19591.7972634639749417028.stgit@tstruk-mobl1.jf.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Tadeusz,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on next-20180608]
[cannot apply to v4.17]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Tadeusz-Struk/tpm-add-ptr-to-the-tpm_space-struct-to-file_priv/20180612-082203
config: i386-randconfig-x008-201823 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All error/warnings (new ones prefixed by >>):

>> drivers/char//tpm/tpm-dev-common.c:223:1: warning: data definition has no type or storage class
    __exitcall(tpm_dev_common_exit);
    ^~~~~~~~~~
>> drivers/char//tpm/tpm-dev-common.c:223:1: error: type defaults to 'int' in declaration of '__exitcall' [-Werror=implicit-int]
>> drivers/char//tpm/tpm-dev-common.c:223:1: warning: parameter names (without types) in function declaration
   drivers/char//tpm/tpm-dev-common.c:215:20: warning: 'tpm_dev_common_exit' defined but not used [-Wunused-function]
    static void __exit tpm_dev_common_exit(void)
                       ^~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +223 drivers/char//tpm/tpm-dev-common.c

   222	
 > 223	__exitcall(tpm_dev_common_exit);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


    [ Part 2, Application/GZIP 28 KB. ]
    [ Unable to print this part. ]
