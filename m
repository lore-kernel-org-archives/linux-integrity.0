Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54792 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752166AbeFEWrs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 5 Jun 2018 18:47:48 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w55Mi8gb145952
        for <linux-integrity@vger.kernel.org>; Tue, 5 Jun 2018 18:47:47 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2je3arrjkv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 05 Jun 2018 18:47:47 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Tue, 5 Jun 2018 23:47:45 +0100
Subject: Re: [PATCH v4a 8/8] module: replace the existing LSM hook in
 init_module
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Kees Cook <keescook@chromium.org>
Cc: Paul Moore <paul@paul-moore.com>,
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
        Jeff Vander Stoep <jeffv@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>
In-Reply-To: <CAGXu5j+9P9HLvwC4WfHoxXsz7vYA_raStVDPzA=tNR9f9vr9=Q@mail.gmail.com>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
         <1527616920-5415-9-git-send-email-zohar@linux.vnet.ibm.com>
         <CAHC9VhQL+CsqKL83fSZhjEZVSjKKfmLULvehXZ8SZhtK5xzLMQ@mail.gmail.com>
         <1527635645.3534.39.camel@linux.vnet.ibm.com>
         <CAHC9VhQQX-JAnV-6jEOsug-6siyO9mrNa=rYK9Whg-MYcfHxgA@mail.gmail.com>
         <1527780226.3427.20.camel@linux.vnet.ibm.com>
         <CAGXu5jLXSEWHorm6=h9+1cP-y8ZX2_ALcra6g9x7Tm-O0kU3DQ@mail.gmail.com>
         <1528234513.3557.16.camel@linux.vnet.ibm.com>
         <CAGXu5j+9P9HLvwC4WfHoxXsz7vYA_raStVDPzA=tNR9f9vr9=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 05 Jun 2018 18:40:11 -0400
Mime-Version: 1.0
Message-Id: <1528238411.3557.32.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 2018-06-05 at 15:26 -0700, Kees Cook wrote:
> On Tue, Jun 5, 2018 at 2:35 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> > On Tue, 2018-06-05 at 12:45 -0700, Kees Cook wrote:
> >
> >> And if you must have a separate enum, please change this to fail
> >> closed instead of open (and mark the fall-through):
> >>
> >> int rc = -EPERM;
> >>
> >> switch (id) {
> >> case LOADING_MODULE:
> >>     rc = loadpin_read_file(NULL, READING_MODULE);
> >>     /* Fall-through */
> >> default:
> >>     break;
> >> }
> >
> > This will fail the sysfs firmware fallback loading and the kexec_load
> > syscall without any message, as you have for init_module.  Is that
> > what you want?
> 
> I'd prefer there be a full mapping of the enums so that everything
> gets passed into loadpin_read_file() :)
> 
> Can the enum be shared or is that nonsensical?

Considering this is v4 of the patch set, it's pretty obvious I did
everything possible not to define a new LSM hook.  Even if we can't
re-use the existing enum, we could define the new enum in terms
of __kernel_read_file_id.

enum kernel_load_data_id {
        __kernel_read_file_id(__data_id_enumify)
};

static const char * const kernel_load_data_str[] = {
        __kernel_read_file_id(__data_id_stringify)
};

Eric, Serge, would using either the existing __kernel_read_file_id
enum or the above definitions be acceptable?

Mimi
