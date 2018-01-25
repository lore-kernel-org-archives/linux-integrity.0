Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f54.google.com ([209.85.214.54]:38588 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932637AbeAYA6l (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Jan 2018 19:58:41 -0500
Received: by mail-it0-f54.google.com with SMTP id w14so7385040itc.3
        for <linux-integrity@vger.kernel.org>; Wed, 24 Jan 2018 16:58:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <8b7f9729-af09-a59e-0cd0-8db58d82ea56@schaufler-ca.com>
References: <20180108213620.170042-1-mjg59@google.com> <CACdnJuutxPpzr4DPaJLuffHCcMWQN_22dA6wzxMQq3XR2R6+Gg@mail.gmail.com>
 <8b7f9729-af09-a59e-0cd0-8db58d82ea56@schaufler-ca.com>
From: Matthew Garrett <mjg59@google.com>
Date: Thu, 25 Jan 2018 11:58:39 +1100
Message-ID: <CACdnJutphETV-aGj9QTN0Z=VyQYod9R7=HjQSrXDVL2ASQfOzA@mail.gmail.com>
Subject: Re: [PATCH V6 1/2] security: Add a cred_getsecid hook
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        James Morris <james.l.morris@oracle.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
        LSM List <linux-security-module@vger.kernel.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Jan 22, 2018 at 5:14 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 1/21/2018 9:27 PM, Matthew Garrett wrote:
>> On Tue, Jan 9, 2018 at 8:36 AM, Matthew Garrett <mjg59@google.com> wrote:
>>> For IMA purposes, we want to be able to obtain the prepared secid in the
>>> bprm structure before the credentials are committed. Add a cred_getsecid
>>> hook that makes this possible.
>> Any feedback on this version of the set?
>
>
> Sorry for the delay. I'm having a mindset crisis on secids just
> now, and I'm not completely sure if I have any issue with this
> particular hook. Don't wait for me. If everyone else is OK with
> it, go ahead.

Thanks Casey - Mimi, are you ok with the IMA changes? If so, which
tree should these go through?
