Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38048 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751980AbdLDM4E (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 Dec 2017 07:56:04 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vB4Cs2lb139036
        for <linux-integrity@vger.kernel.org>; Mon, 4 Dec 2017 07:56:03 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2en5kb4492-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 04 Dec 2017 07:56:03 -0500
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 4 Dec 2017 12:56:00 -0000
Subject: Re: IMA-EVM-Utils OpenSSL1.1 interface update
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Bruno E. O. Meneguele" <brdeoliv@redhat.com>,
        dmitry.kasatkin@gmail.com
Cc: linux-integrity@vger.kernel.org
Date: Mon, 04 Dec 2017 07:55:57 -0500
In-Reply-To: <20171201181522.GB3056@glitch>
References: <20171201181522.GB3056@glitch>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1512392157.3977.36.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2017-12-01 at 16:15 -0200, Bruno E. O. Meneguele wrote:
> Hi folks,
> 
> I don't really know what are your best interest in update ima-evm-utils
> 1.0 package to support OpenSSL 1.1 new interface considering lots of
> distros are chaging to it as the default one. Some are maintaining
> compatibility packages to OpenSSL 1.0, but usually it remains available
> in the official repos for something like 1 or 2 releases and then
> removed completely.
> 
> Actually I have a simple/small port of it to OpenSSL 1.1 that I plan to
> maintain for Fedora's Rawhide (next release, f28) package. Do you guys
> have interest on it? I could post it as a patch.
> 
> Thanks!

Yes, I'd really appreciate it.  We need to release the new EVM
portable signature support as well.

thanks,

Mimi
