Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:48737 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932180AbeBSWvB (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Feb 2018 17:51:01 -0500
Date: Tue, 20 Feb 2018 06:50:34 +0800
From: kbuild test robot <lkp@intel.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: kbuild-all@01.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Seth Forshee <seth.forshee@canonical.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Dongsu Park <dongsu@kinvolk.io>,
        Alban Crequy <alban@kinvolk.io>,
        "Serge E . Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH v1 1/2] ima: fail signature verification on untrusted
 filesystems
Message-ID: <201802200637.f8w7cht0%fengguang.wu@intel.com>
References: <1519053483-18396-2-git-send-email-zohar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="HlL+5n6rz5pIUxbD"
In-Reply-To: <1519053483-18396-2-git-send-email-zohar@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Mimi,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.16-rc2 next-20180219]
[cannot apply to integrity/next]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Mimi-Zohar/ima-untrusted-filesystems/20180220-040517
config: i386-randconfig-s1-201807 (attached as .config)
compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

>> WARNING: vmlinux.o(.text+0x2afe73): Section mismatch in reference from the function ima_match_policy() to the variable .init.data:ima_fail_untrusted_fs
   The function ima_match_policy() references
   the variable __initdata ima_fail_untrusted_fs.
   This is often because ima_match_policy lacks a __initdata
   annotation or the annotation of ima_fail_untrusted_fs is wrong.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


    [ Part 2, Application/GZIP 26 KB. ]
    [ Unable to print this part. ]
