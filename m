Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:16742 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727013AbeINTMG (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 14 Sep 2018 15:12:06 -0400
Date: Fri, 14 Sep 2018 21:50:31 +0800
From: kbuild test robot <lkp@intel.com>
To: Nayna Jain <nayna@linux.vnet.ibm.com>
Cc: kbuild-all@01.org, linux-integrity@vger.kernel.org,
        zohar@linux.ibm.com, linux-security-module@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com, jforbes@redhat.com,
        Eric Richter <erichte@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 6/6] x86/ima: define arch_get_ima_policy() for x86
Message-ID: <201809142126.oa45Rj76%fengguang.wu@intel.com>
References: <20180914080005.6138-7-nayna@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="7AUc2qLy4jB3hD7Z"
In-Reply-To: <20180914080005.6138-7-nayna@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Eric,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on integrity/next-integrity]
[also build test ERROR on v4.19-rc3 next-20180913]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Nayna-Jain/Add-support-for-architecture-specific-IMA-policies/20180914-202254
base:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity
config: i386-randconfig-s1-201836 (attached as .config)
compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

>> arch/x86//kernel/ima_arch.c:28:21: error: redefinition of 'arch_get_ima_policy'
    const char * const *arch_get_ima_policy(void)
                        ^~~~~~~~~~~~~~~~~~~
   In file included from arch/x86//kernel/ima_arch.c:6:0:
   include/linux/ima.h:45:35: note: previous definition of 'arch_get_ima_policy' was here
    static inline const char * const *arch_get_ima_policy(void)
                                      ^~~~~~~~~~~~~~~~~~~

vim +/arch_get_ima_policy +28 arch/x86//kernel/ima_arch.c

    27	
  > 28	const char * const *arch_get_ima_policy(void)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


    [ Part 2, Application/GZIP 29 KB. ]
    [ Unable to print this part. ]
