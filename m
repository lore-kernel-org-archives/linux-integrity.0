Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-ua0-f194.google.com ([209.85.217.194]:44125 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751755AbeFEMTw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 5 Jun 2018 08:19:52 -0400
Received: by mail-ua0-f194.google.com with SMTP id f30-v6so1444703uab.11
        for <linux-integrity@vger.kernel.org>; Tue, 05 Jun 2018 05:19:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180605040920.GA19747@mail.hallyn.com>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1528121025.3237.116.camel@linux.vnet.ibm.com> <CAGXu5jJGrPtOUa8f4pMiZTiYBEP_eVJ1oEUqum8YBr9JbfuLmg@mail.gmail.com>
 <20180605040920.GA19747@mail.hallyn.com>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 5 Jun 2018 05:19:50 -0700
Message-ID: <CAGXu5j+UfR94xAoKsyZY9dhzREH-b2fhTAtQLfX33BhDdMVweA@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] kexec/firmware: support system wide policy
 requiring signatures
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <james.l.morris@oracle.com>,
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
        Jessica Yu <jeyu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Jun 4, 2018 at 9:09 PM, Serge E. Hallyn <serge@hallyn.com> wrote:
> Personally I agree with Eric and prefer a new hook.  I don't feel strongly
> enough about it to keep bikeshedding, but since this set already exists,
> it seems like the way to go.

And the new hook is "load stuff without a file descriptor"?

-Kees

-- 
Kees Cook
Pixel Security
