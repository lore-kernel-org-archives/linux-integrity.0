Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50122 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732459AbeHCMGm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Aug 2018 08:06:42 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w73A8uM5148604
        for <linux-integrity@vger.kernel.org>; Fri, 3 Aug 2018 06:11:05 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kmkknkgqd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 03 Aug 2018 06:11:05 -0400
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Fri, 3 Aug 2018 04:11:04 -0600
Subject: Re: [PATCH 1/4] ima: add support for arch specific policies
To: kbuild test robot <lkp@intel.com>,
        Eric Richter <erichte@linux.vnet.ibm.com>
Cc: kbuild-all@01.org,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Justin Forbes <jforbes@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>
References: <20180725233200.761-2-erichte@linux.vnet.ibm.com>
 <201807281011.3IfKWpyx%fengguang.wu@intel.com>
From: Nayna Jain <nayna@linux.vnet.ibm.com>
Date: Fri, 3 Aug 2018 15:38:36 +0530
MIME-Version: 1.0
In-Reply-To: <201807281011.3IfKWpyx%fengguang.wu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <b47cddd8-44ea-1175-a6ee-25f06ad4a185@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



On 07/28/2018 07:54 AM, kbuild test robot wrote:
> Hi Nayna,
>
> Thank you for the patch! Perhaps something to improve:

Thanks for the report. I will address or squash the changes with the 
existing PATCH 1/4 in the next version.
The warning about NULL dereference in PATCH 4/4 is related to changes in 
PATCH 1/4, so will fix in PATCH 1/4 itself.

Thanks & Regards,
     - Nayna


>
> [auto build test WARNING on integrity/next-integrity]
> [also build test WARNING on next-20180727]
> [cannot apply to v4.18-rc6]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Eric-Richter/ima-add-support-for-arch-specific-policies/20180728-072442
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity
> reproduce:
>          # apt-get install sparse
>          make ARCH=x86_64 allmodconfig
>          make C=1 CF=-D__CHECK_ENDIAN__
>
>
> sparse warnings: (new ones prefixed by >>)
>
>>> security/integrity/ima/ima_policy.c:198:23: sparse: symbol 'arch_policy_rules' was not declared. Should it be static?
>>> security/integrity/ima/ima_policy.c:199:23: sparse: symbol 'arch_policy_entry' was not declared. Should it be static?
>     include/linux/slab.h:631:13: sparse: undefined identifier '__builtin_mul_overflow'
>     include/linux/slab.h:631:13: sparse: not a function <noident>
>     include/linux/slab.h:631:13: sparse: call with no type!
>
> Please review and possibly fold the followup patch.
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
>
