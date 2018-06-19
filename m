Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44872 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751677AbeFSWVW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 19 Jun 2018 18:21:22 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5JM9Mas040207
        for <linux-integrity@vger.kernel.org>; Tue, 19 Jun 2018 18:21:21 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jq71h04tk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 19 Jun 2018 18:21:21 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Tue, 19 Jun 2018 23:21:19 +0100
Subject: Re: IMA: Deadlock in ima_appraise_measurement when /bin/kmod
 carries a digsig in security.evm
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthias Gerstner <mgerstner@suse.de>,
        linux-integrity@vger.kernel.org
Date: Tue, 19 Jun 2018 18:21:15 -0400
In-Reply-To: <20180618145628.GD8123@f195.suse.de>
References: <20180618145628.GD8123@f195.suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1529446875.3269.6.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Matthias,

On Mon, 2018-06-18 at 16:56 +0200, Matthias Gerstner wrote:
> Hello,
> 
> I came across a deadlock issue when /bin/kmod carries a digital
> signature in security.evm.
> 
> There was a patch suggested on the old linux-ima-devel mailing list here
> <https://sourceforge.net/p/linux-ima/mailman/message/35628097/>, but it
> seems not to have made it into the official tree.
> 
> Can anybody tell me what the status of this patch is?

Somehow I missed it.  A more generic patch is currently queued, which
should resolve this problem as well.  Please try commit fdc33c29b022
("evm: Don't deadlock if a crypto algorithm is unavailable") in the
next-integrity-queued branch.

Mimi
