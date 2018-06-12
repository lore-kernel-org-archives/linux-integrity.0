Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:30078 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933295AbeFLRjD (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Jun 2018 13:39:03 -0400
Subject: Re: [PATCH v2 2/2] tpm: add support for nonblocking operation
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <152876282414.19591.7972634639749417028.stgit@tstruk-mobl1.jf.intel.com>
 <201806120803.W0vjfLEH%fengguang.wu@intel.com>
From: Tadeusz Struk <tadeusz.struk@intel.com>
Message-ID: <23f79ed3-be69-2a80-b4d8-b9af8491bcd1@intel.com>
Date: Tue, 12 Jun 2018 10:39:00 -0700
MIME-Version: 1.0
In-Reply-To: <201806120803.W0vjfLEH%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 06/11/2018 07:53 PM, kbuild test robot wrote:
> Hi Tadeusz,
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> All error/warnings (new ones prefixed by >>):
> 
>>> drivers/char//tpm/tpm-dev-common.c:223:1: warning: data definition has no type or storage class
>     __exitcall(tpm_dev_common_exit);
>     ^~~~~~~~~~
>>> drivers/char//tpm/tpm-dev-common.c:223:1: error: type defaults to 'int' in declaration of '__exitcall' [-Werror=implicit-int]
>>> drivers/char//tpm/tpm-dev-common.c:223:1: warning: parameter names (without types) in function declaration
>    drivers/char//tpm/tpm-dev-common.c:215:20: warning: 'tpm_dev_common_exit' defined but not used [-Wunused-function]
>     static void __exit tpm_dev_common_exit(void)
>                        ^~~~~~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors
> 
> vim +223 drivers/char//tpm/tpm-dev-common.c
> 
>    222	
>  > 223	__exitcall(tpm_dev_common_exit);

It is complaining about __exitcall here, because there is a module_exit() call
in drivers/char/tpm/tpm-interface.c already and the two files are build into the same object.
It is strange that the problem only manifests itself when cross compiling with ARCH=i386. Native 64bit build works fine.
I will simply call the tpm_dev_common_exit() from the tpm_exit() and re-spin a v3.
Thanks again for the report.
-- 
Tadeusz
