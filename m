Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-ua0-f196.google.com ([209.85.217.196]:40235 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751853AbeFENnd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 5 Jun 2018 09:43:33 -0400
Received: by mail-ua0-f196.google.com with SMTP id l11-v6so867982uak.7
        for <linux-integrity@vger.kernel.org>; Tue, 05 Jun 2018 06:43:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180605132542.GA26722@mail.hallyn.com>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1528121025.3237.116.camel@linux.vnet.ibm.com> <CAGXu5jJGrPtOUa8f4pMiZTiYBEP_eVJ1oEUqum8YBr9JbfuLmg@mail.gmail.com>
 <20180605040920.GA19747@mail.hallyn.com> <CAGXu5j+UfR94xAoKsyZY9dhzREH-b2fhTAtQLfX33BhDdMVweA@mail.gmail.com>
 <20180605132542.GA26722@mail.hallyn.com>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 5 Jun 2018 06:43:31 -0700
Message-ID: <CAGXu5j+vsYHBpH75i=GxVfi0HgvsAW6zgz6V-eO8ZD13ykq2mw@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] kexec/firmware: support system wide policy
 requiring signatures
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Jun 5, 2018 at 6:25 AM, Serge E. Hallyn <serge@hallyn.com> wrote:
> Quoting Kees Cook (keescook@chromium.org):
>> On Mon, Jun 4, 2018 at 9:09 PM, Serge E. Hallyn <serge@hallyn.com> wrote:
>> > Personally I agree with Eric and prefer a new hook.  I don't feel strongly
>> > enough about it to keep bikeshedding, but since this set already exists,
>> > it seems like the way to go.
>>
>> And the new hook is "load stuff without a file descriptor"?
>
> Yes.  Load stuff based on my own credentials not those attached
> to a file.

Okay, I can live with that. :)

-- 
Kees Cook
Pixel Security
