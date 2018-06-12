Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:23929 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751861AbeFLEqg (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Jun 2018 00:46:36 -0400
Subject: Re: [PATCH v2 2/2] tpm: add support for nonblocking operation
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <152876282414.19591.7972634639749417028.stgit@tstruk-mobl1.jf.intel.com>
 <201806120803.W0vjfLEH%fengguang.wu@intel.com>
From: Tadeusz Struk <tadeusz.struk@intel.com>
Message-ID: <359fe9af-ba17-e23b-a21e-c3c94f23b5ff@intel.com>
Date: Mon, 11 Jun 2018 21:46:35 -0700
MIME-Version: 1.0
In-Reply-To: <201806120803.W0vjfLEH%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 06/11/2018 07:53 PM, kbuild test robot wrote:
> Hi Tadeusz,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on char-misc/char-misc-testing]
> [also build test ERROR on next-20180608]
> [cannot apply to v4.17]

Hi,
Thanks for the report. This patch should go on top of
https://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git/?h=next-tpm
I will check the config tomorrow.
Thanks,
-- 
Tadeusz
