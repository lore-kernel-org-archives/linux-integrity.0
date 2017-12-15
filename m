Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:7241 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756629AbdLOOqt (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 Dec 2017 09:46:49 -0500
Date: Fri, 15 Dec 2017 16:46:44 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Alexander.Steffen@infineon.com
Cc: shuahkh@osg.samsung.com, linux-integrity@vger.kernel.org
Subject: Re: TPM tests within kselftest?
Message-ID: <20171215144627.jkkbr2pfyomrhsjm@linux.intel.com>
References: <0d71b9ee00a14b689896cac1dcbb6a12@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0d71b9ee00a14b689896cac1dcbb6a12@infineon.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Dec 14, 2017 at 04:23:29PM +0000, Alexander.Steffen@infineon.com wrote:
> Hi Jarkko,
> 
> during the Kernel Summit in Prague I talked with Shuah Khan about
> kselftest and the possibility to integrate TPM tests into that
> framework. What would you think about your tests
> (https://github.com/jsakkine-intel/tpm2-scripts) living there?
> 
> This way, those tests would get more visibility/popularity with other
> developers, and thus hopefully more contributors that can use that
> framework as a starting point. It also allows us to have a common test
> set, that all TPM developers can easily use for their work. And the
> tests being integrated into the kernel repository would avoid issues
> like I had just now, where your new test for invalid command codes
> failed when I tried to run it on an older kernel that did not have
> that functionality implemented.
> 
> Currently, most tests within kselftest are not implemented in Python,
> but Shuah did not sound strictly opposed to that idea. In fact, some
> Python-based tests already have made it into the tree
> (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/tc-testing),
> though they do not seem to be called by kselftest by default.
> 
> Alexander

I'm fine with this.

/Jarkko
