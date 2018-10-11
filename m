Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34958 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728164AbeJLCGM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Oct 2018 22:06:12 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9BIW82I148011
        for <linux-integrity@vger.kernel.org>; Thu, 11 Oct 2018 14:37:46 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2n29jsqv7h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 11 Oct 2018 14:37:45 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 11 Oct 2018 19:37:42 +0100
Subject: Re: [PATCH 1/3] VFS: Add a call to obtain a file's hash
From: Mimi Zohar <zohar@linux.ibm.com>
To: Matthew Garrett <mjg59@google.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Date: Thu, 11 Oct 2018 14:37:27 -0400
In-Reply-To: <CACdnJuscqpk-48Ahb4nNHNxawPq53FLKbLAdmmhmN_pp=jdqDA@mail.gmail.com>
References: <20181004203007.217320-1-mjg59@google.com>
         <20181004203007.217320-2-mjg59@google.com>
         <1539271337.11939.78.camel@linux.ibm.com>
         <CACdnJuupQ1vj-H-_Ru+uaGJa-Lhev=52=2RGyTbR1ms4LN3DpA@mail.gmail.com>
         <CACdnJuscqpk-48Ahb4nNHNxawPq53FLKbLAdmmhmN_pp=jdqDA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1539283047.11939.95.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 2018-10-11 at 11:24 -0700, Matthew Garrett wrote:
> On Thu, Oct 11, 2018 at 11:21 AM Matthew Garrett <mjg59@google.com> wrote:
> >
> > On Thu, Oct 11, 2018 at 8:22 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > >
> > > This patch description starts out saying that IMA needs the file hash
> > > without explaining why.  Without that explanation, simply extracting
> > > the file hash included in the file signature might sound plausible,
> > > but kind of defeats the purpose of IMA.
> >
> > I'm not sure how it defeats the purpose - IMA wants to know the hash
> > of a file so it can either log it or compare it against a signature,
> > and it currently obtains this hash by reading the entire file at
> > measurement time. If the filesystem later returns different data then
> > IMA won't notice, which allows a malicious filesystem to bypass the
> > measurements - there's no guarantee that we won't evict large parts of
> > the copy of an executable that IMA read, and the filesystem can give
> > us back a modified page when we page it back in. So IMA fundamentally
> > relies on the filesystem to be trustworthy, and if we rely on the
> > filesystem to be trustworthy then we should be able to rely on it to
> > accurately store and provide the hash of a file.
> 
> Oh, to clarify on the signature part of things - it would obviously be
> inappropriate to, say, just read the hash out of security.ima and hand
> that back.

Right, reading it either directly or extracted from the file signature
stored in security.ima.

> But for a hypothetical case where the filesystem itself
> verifies the signature, then the filesystem would abort the
> transaction if the signature didn't match and it seems reasonable to
> avoid doing the validation twice (once up front and then again on
> every read)

Right, this is a hypothetical scenario as far as I'm aware, since none
of the filesystems are currently calculating and storing the file
hash.  The default should be for IMA to re-calculate the file hash.

Mimi
