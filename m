Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:39190 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966563AbeE2Vr5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 May 2018 17:47:57 -0400
Received: by mail-lf0-f68.google.com with SMTP id t134-v6so1054878lff.6
        for <linux-integrity@vger.kernel.org>; Tue, 29 May 2018 14:47:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4331521.GQBdaJNAj6@x2>
References: <20180524201105.3179904-1-stefanb@linux.vnet.ibm.com>
 <20180524201105.3179904-6-stefanb@linux.vnet.ibm.com> <CAHC9VhQTFPwz5tpL133DQuXDbZR4P7zy4m3hb4nwm9OSf4RNgQ@mail.gmail.com>
 <4331521.GQBdaJNAj6@x2>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 29 May 2018 17:47:55 -0400
Message-ID: <CAHC9VhRp82u4puDt82E0G4ax4tb9301U7XK6+0ZT1rrP-ZgaRw@mail.gmail.com>
Subject: Re: [PATCH 5/8] integrity: Add exe= and tty= before res= to integrity audits
To: Steve Grubb <sgrubb@redhat.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: zohar@linux.vnet.ibm.com, linux-integrity@vger.kernel.org,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, May 29, 2018 at 5:35 PM, Steve Grubb <sgrubb@redhat.com> wrote:
> On Tuesday, May 29, 2018 5:19:39 PM EDT Paul Moore wrote:
>> On Thu, May 24, 2018 at 4:11 PM, Stefan Berger
>>
>> <stefanb@linux.vnet.ibm.com> wrote:
>> > Use the new public audit functions to add the exe= and tty=
>> > parts to the integrity audit records. We place them before
>> > res=.
>> >
>> > Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>> > Suggested-by: Steve Grubb <sgrubb@redhat.com>
>> > ---
>> >
>> >  security/integrity/integrity_audit.c | 2 ++
>> >  1 file changed, 2 insertions(+)
>> >
>> > diff --git a/security/integrity/integrity_audit.c
>> > b/security/integrity/integrity_audit.c index db30763d5525..8d25d3c4dcca
>> > 100644
>> > --- a/security/integrity/integrity_audit.c
>> > +++ b/security/integrity/integrity_audit.c
>> > @@ -56,6 +56,8 @@ void integrity_audit_msg(int audit_msgno, struct inode
>> > *inode,>
>> >                 audit_log_untrustedstring(ab, inode->i_sb->s_id);
>> >                 audit_log_format(ab, " ino=%lu", inode->i_ino);
>> >
>> >         }
>> >
>> > +       audit_log_d_path_exe(ab, current->mm);
>> > +       audit_log_tty(ab, current);
>>
>> NACK
>>
>> Please add the new fields to the end of the audit record, thank you.
>
> Let's see what an example event looks like before NACK'ing this. Way back in
> 2013 the IMA events were good. I think this is repairing the event after some
> drift.

Can you reference a specific commit, or point in time during 2013?
Looking at the git log quickly, if I go back to commit d726d8d719b6
("integrity: move integrity_audit_msg()") from March 18, 2013 (the
commit that created integrity_audit.c) the field ordering appears to
be the same as it today.

My NACK still stands.

-- 
paul moore
www.paul-moore.com
