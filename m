Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50330 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751912AbeFEOGL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 5 Jun 2018 10:06:11 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w55DxE9p123233
        for <linux-integrity@vger.kernel.org>; Tue, 5 Jun 2018 10:06:10 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jdt2n6q99-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 05 Jun 2018 10:06:10 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Tue, 5 Jun 2018 15:06:08 +0100
Subject: Re: [PATCH v4 0/8] kexec/firmware: support system wide policy
 requiring signatures
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Kees Cook <keescook@chromium.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jessica Yu <jeyu@kernel.org>, James Morris <jmorris@namei.org>
Date: Tue, 05 Jun 2018 10:05:49 -0400
In-Reply-To: <CAGXu5j+vsYHBpH75i=GxVfi0HgvsAW6zgz6V-eO8ZD13ykq2mw@mail.gmail.com>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
         <1528121025.3237.116.camel@linux.vnet.ibm.com>
         <CAGXu5jJGrPtOUa8f4pMiZTiYBEP_eVJ1oEUqum8YBr9JbfuLmg@mail.gmail.com>
         <20180605040920.GA19747@mail.hallyn.com>
         <CAGXu5j+UfR94xAoKsyZY9dhzREH-b2fhTAtQLfX33BhDdMVweA@mail.gmail.com>
         <20180605132542.GA26722@mail.hallyn.com>
         <CAGXu5j+vsYHBpH75i=GxVfi0HgvsAW6zgz6V-eO8ZD13ykq2mw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1528207549.3237.149.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 2018-06-05 at 06:43 -0700, Kees Cook wrote:
> On Tue, Jun 5, 2018 at 6:25 AM, Serge E. Hallyn <serge@hallyn.com> wrote:
> > Quoting Kees Cook (keescook@chromium.org):
> >> On Mon, Jun 4, 2018 at 9:09 PM, Serge E. Hallyn <serge@hallyn.com> wrote:
> >> > Personally I agree with Eric and prefer a new hook.  I don't feel strongly
> >> > enough about it to keep bikeshedding, but since this set already exists,
> >> > it seems like the way to go.
> >>
> >> And the new hook is "load stuff without a file descriptor"?
> >
> > Yes.  Load stuff based on my own credentials not those attached
> > to a file.
> 
> Okay, I can live with that. :)

Can I get your Ack on the loadpin changes in v4a patch 8/8?

Mimi
