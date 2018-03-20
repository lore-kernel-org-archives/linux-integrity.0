Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34338 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751330AbeCTQLR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Mar 2018 12:11:17 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2KGArWe093426
        for <linux-integrity@vger.kernel.org>; Tue, 20 Mar 2018 12:11:17 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2gu4t4jke7-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 20 Mar 2018 12:11:16 -0400
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Tue, 20 Mar 2018 16:11:14 -0000
Subject: Re: Problem mounting pseudo filesystems with SMACK and IMA enabled.
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Martin Townsend <mtownsend1973@gmail.com>
Cc: linux-integrity@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Dmitry Kasatkin <dmitry.kasatkin@huawei.com>,
        LSM <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Date: Tue, 20 Mar 2018 12:11:09 -0400
In-Reply-To: <CABatt_yk+pgwxHVv+RY08xFDOfzxb4w6ELW7RxhW6gWQ=5Hvnw@mail.gmail.com>
References: <CABatt_zunDV_g3oR5_O5GMm0EVEnT0LEnmjp5PQgu26Q6T+4SA@mail.gmail.com>
         <1521206743.3503.29.camel@linux.vnet.ibm.com>
         <CABatt_zxC1W-OirRLM-PVERAkUZaJDSnRDc_i4a7ebh-NJZ9Ag@mail.gmail.com>
         <1521211762.3503.46.camel@linux.vnet.ibm.com>
         <77f5ac13-dd79-abf7-13b2-336bf799a25c@schaufler-ca.com>
         <CABatt_yk_73BsgaD7UsHOL9wse0FxR=i1YXneUfx6aUiBra_JQ@mail.gmail.com>
         <CABatt_zM0Uu2fEwyORKTLYMC2_KeqSkcye1toBxhyjkgOUr62Q@mail.gmail.com>
         <1521474460.3503.191.camel@linux.vnet.ibm.com>
         <CABatt_wfwRqJRie=eoaaXnfxd7EUBhDL-jPjPbBHbwcnpMWj7g@mail.gmail.com>
         <1521552744.22230.25.camel@linux.vnet.ibm.com>
         <CABatt_yk+pgwxHVv+RY08xFDOfzxb4w6ELW7RxhW6gWQ=5Hvnw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1521562269.22230.40.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 2018-03-20 at 15:01 +0000, Martin Townsend wrote:
> 
> Not sure why SMACK is not already there, do you want me to submit this
> patch formally or is there a good reason for the omission?

At some point, we should introduce a flag indicating a pseudo
fileesystem, but for now including SMACK in the list of pseudo
filesystems not measured sounds right. 

thanks,

Mimi
