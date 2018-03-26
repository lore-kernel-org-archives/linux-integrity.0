Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45804 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751739AbeCZSbW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Mar 2018 14:31:22 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2QITRY5053624
        for <linux-integrity@vger.kernel.org>; Mon, 26 Mar 2018 14:31:21 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2gy4neuy88-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 26 Mar 2018 14:31:21 -0400
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 26 Mar 2018 19:31:19 +0100
Subject: Re: [PATCH v3] ima: Fallback to the builtin hash algorithm
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Petr Vorel <pvorel@suse.cz>
Cc: linux-integrity@vger.kernel.org
Date: Mon, 26 Mar 2018 14:31:14 -0400
In-Reply-To: <20180326081627.GB12097@x230>
References: <20180323134108.9435-1-pvorel@suse.cz>
         <1522000870.3541.34.camel@linux.vnet.ibm.com> <20180326081627.GB12097@x230>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1522089074.3541.95.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2018-03-26 at 10:16 +0200, Petr Vorel wrote:

> Thanks for merging! I've forgotten to add Cc: stable@vger.kernel.org, so I'll send it to
> stable@vger.kernel.org once it gets into mainline (unless you objects, of course).

Sorry, I think it is the maintainer's responsibility, but I forgot to
add it.  Thank you for the reminder.

Mimi
