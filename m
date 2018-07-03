Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:51645 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753148AbeGCMFB (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Jul 2018 08:05:01 -0400
Date: Tue, 3 Jul 2018 20:04:49 +0800
From: kbuild test robot <lkp@intel.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: kbuild-all@01.org, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org, Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v5 4/8] firmware: add call to LSM hook before firmware
 sysfs fallback
Message-ID: <201807031814.ptUHudMj%fengguang.wu@intel.com>
References: <1530542283-26145-5-git-send-email-zohar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="UlVJffcvxoiEqYs2"
In-Reply-To: <1530542283-26145-5-git-send-email-zohar@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Mimi,

I love your patch! Yet something to improve:

[auto build test ERROR on integrity/next-integrity]
[also build test ERROR on v4.18-rc3 next-20180702]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Mimi-Zohar/kexec-firmware-support-system-wide-policy-requiring-signatures/20180703-011114
base:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity
config: x86_64-randconfig-ws0-07031240 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

>> ERROR: "security_kernel_load_data" [drivers/base/firmware_loader/firmware_class.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


    [ Part 2, Application/GZIP 25 KB. ]
    [ Unable to print this part. ]
