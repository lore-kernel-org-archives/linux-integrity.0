Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from sonic316-26.consmr.mail.ne1.yahoo.com ([66.163.187.152]:44530
        "EHLO sonic316-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750991AbeCTQPG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Mar 2018 12:15:06 -0400
Subject: Re: Problem mounting pseudo filesystems with SMACK and IMA enabled.
To: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Martin Townsend <mtownsend1973@gmail.com>
Cc: linux-integrity@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Dmitry Kasatkin <dmitry.kasatkin@huawei.com>,
        LSM <linux-security-module@vger.kernel.org>
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
 <1521562269.22230.40.camel@linux.vnet.ibm.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <942c9bb2-d6ed-0859-3b48-5aabe775b673@schaufler-ca.com>
Date: Tue, 20 Mar 2018 09:14:54 -0700
MIME-Version: 1.0
In-Reply-To: <1521562269.22230.40.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 3/20/2018 9:11 AM, Mimi Zohar wrote:
> On Tue, 2018-03-20 at 15:01 +0000, Martin Townsend wrote:
>> Not sure why SMACK is not already there, do you want me to submit this
>> patch formally or is there a good reason for the omission?
> At some point, we should introduce a flag indicating a pseudo
> fileesystem, but for now including SMACK in the list of pseudo
> filesystems not measured sounds right.

I am also good with that.

>
> thanks,
>
> Mimi
>
>
