Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46466 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750738AbdKPNfr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Nov 2017 08:35:47 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAGDZh6l027033
        for <linux-integrity@vger.kernel.org>; Thu, 16 Nov 2017 08:35:47 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2e9ar1u88c-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 16 Nov 2017 08:35:46 -0500
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Thu, 16 Nov 2017 13:35:34 -0000
Subject: Re: [USER] [PATCH] Add support for portable EVM format
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>, linux-integrity@vger.kernel.org
Date: Thu, 16 Nov 2017 08:35:30 -0500
In-Reply-To: <20171115210527.11488-1-mjg59@google.com>
References: <20171115210527.11488-1-mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1510839330.3711.443.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Matthew,

On Wed, 2017-11-15 at 13:05 -0800, Matthew Garrett wrote:
> Add a --portable argument that generates EVM signatures without using
> the inode number and generation or fs UUID.

Thanks, Matthew.  This patch doesn't seem to be based on the upstream
git repo.  A 'z' option crept in; and a "printf" was removed that
isn't in upstream.

"evm_immutable" should have been in a testing branch until the kernel
code was upstreamed.  Not knowing where it is being used, I'm kind of
hesitant to remove it.  For now, at least, please make sure that the
"evm_immutable" and "evm_portable" flags are mutually exclusive.

thanks,

Mimi
