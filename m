Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:64746 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726735AbeIPRgY (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 16 Sep 2018 13:36:24 -0400
Date: Sun, 16 Sep 2018 15:13:36 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Roberto Sassu <roberto.sassu@huawei.com>
Cc: linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2 1/3] tpm: rename and export tpm2_digest and
 tpm2_algorithms
Message-ID: <20180916121336.GD5040@linux.intel.com>
References: <20180905114202.7757-1-roberto.sassu@huawei.com>
 <20180905114202.7757-2-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180905114202.7757-2-roberto.sassu@huawei.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Sep 05, 2018 at 01:42:00PM +0200, Roberto Sassu wrote:
> Rename tpm2_* to tpm_* and move the definitions to include/linux/tpm.h so
> that these can be used by other kernel subsystems (e.g. IMA).
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

LGTM otherwise but is missing linux-kernel@kernel.org and
linux-security-module@vger.kernel.org. Can you repost with "PATCH
v2,RESEND" with those MLs and also add me to the To-field so that I will
quickly notice this.

/Jarkkko
