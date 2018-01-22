Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:43192 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750828AbeAVF1x (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Jan 2018 00:27:53 -0500
Received: by mail-io0-f179.google.com with SMTP id 72so8174578iom.10
        for <linux-integrity@vger.kernel.org>; Sun, 21 Jan 2018 21:27:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180108213620.170042-1-mjg59@google.com>
References: <20180108213620.170042-1-mjg59@google.com>
From: Matthew Garrett <mjg59@google.com>
Date: Mon, 22 Jan 2018 16:27:51 +1100
Message-ID: <CACdnJuutxPpzr4DPaJLuffHCcMWQN_22dA6wzxMQq3XR2R6+Gg@mail.gmail.com>
Subject: Re: [PATCH V6 1/2] security: Add a cred_getsecid hook
To: linux-integrity <linux-integrity@vger.kernel.org>
Cc: James Morris <james.l.morris@oracle.com>,
        Matthew Garrett <mjg59@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
        Casey Schaufler <casey@schaufler-ca.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Jan 9, 2018 at 8:36 AM, Matthew Garrett <mjg59@google.com> wrote:
> For IMA purposes, we want to be able to obtain the prepared secid in the
> bprm structure before the credentials are committed. Add a cred_getsecid
> hook that makes this possible.

Any feedback on this version of the set?
