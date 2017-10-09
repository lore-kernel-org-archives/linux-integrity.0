Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33364 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755711AbdJIXKz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Oct 2017 19:10:55 -0400
Received: by mail-lf0-f65.google.com with SMTP id j73so10305520lfg.0
        for <linux-integrity@vger.kernel.org>; Mon, 09 Oct 2017 16:10:54 -0700 (PDT)
Date: Tue, 10 Oct 2017 02:10:52 +0300
From: Mikhail Kurinnoi <viewizard@viewizard.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Matthew Garrett <mjg59@google.com>,
        linux-integrity@vger.kernel.org,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Subject: Re: RFC: Make it practical to ship EVM signatures
Message-ID: <20171010021052.47d42db6@totoro>
In-Reply-To: <1507585253.3748.57.camel@linux.vnet.ibm.com>
References: <20170927221653.11219-1-mjg59@google.com>
        <1506629560.5691.33.camel@linux.vnet.ibm.com>
        <CACdnJuuveRvCx57ZnYmRWbiwh3XU7AbxZD2W-Gq_dh_h_6L9Mg@mail.gmail.com>
        <1506646397.5691.64.camel@linux.vnet.ibm.com>
        <CACdnJuueNfLdDnCsmotGhLC58cJXXh35FeZzipJ_ZshScPM=qA@mail.gmail.com>
        <1506711726.5691.141.camel@linux.vnet.ibm.com>
        <CACdnJuvYNnePfz4H-D=DGMHbrbmZ52JWFoLqX120ALV=o4wwcw@mail.gmail.com>
        <1506715304.5691.151.camel@linux.vnet.ibm.com>
        <CACdnJutXT6yU70R07m7Nd=7d6RbZr0Nti_r54Z7CffiK2r17zA@mail.gmail.com>
        <1507571511.3748.9.camel@linux.vnet.ibm.com>
        <CACdnJuv8QSkVNWf7FY2-jakiO2sd8gh1oRTji4w3fvic54kfmA@mail.gmail.com>
        <1507572900.3748.21.camel@linux.vnet.ibm.com>
        <CACdnJuvOW0Pc42Nuh4QVy4xdYsaUa=H9i=YZW+XB+bg-YnDCUQ@mail.gmail.com>
        <1507574441.3748.40.camel@linux.vnet.ibm.com>
        <20171009232314.545de76a@totoro>
        <1507583449.3748.46.camel@linux.vnet.ibm.com>
        <20171010003326.6409ae23@totoro>
        <1507585253.3748.57.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

? Mon, 09 Oct 2017 17:40:53 -0400
Mimi Zohar <zohar@linux.vnet.ibm.com> ?????:

> [Cc'ing Dmitry Kasatkin]
> 
> On Tue, 2017-10-10 at 00:33 +0300, Mikhail Kurinnoi wrote:
> > ? Mon, 09 Oct 2017 17:10:49 -0400
> > Mimi Zohar <zohar@linux.vnet.ibm.com> ?????:
> >   
> > > On Mon, 2017-10-09 at 23:23 +0300, Mikhail Kurinnoi wrote:  
> > > > ? Mon, 09 Oct 2017 14:40:41 -0400
> > > > Mimi Zohar <zohar@linux.vnet.ibm.com> ?????:
> > > >     
> > > > > On Mon, 2017-10-09 at 11:18 -0700, Matthew Garrett wrote:    
> > > > > > On Mon, Oct 9, 2017 at 11:15 AM, Mimi Zohar
> > > > > > <zohar@linux.vnet.ibm.com> wrote:      
> > > > > > > On Mon, 2017-10-09 at 10:59 -0700, Matthew Garrett
> > > > > > > wrote:      
> > > > > > >> Ok, that makes sense. But for cases where we do have
> > > > > > >> security.ima, the inode doesn't seem to provide
> > > > > > >> additional security but does make deployment more
> > > > > > >> difficult. Does supporting this use case seem
> > > > > > >> reasonable?      
> > > > > > >
> > > > > > > Yes!      
> > > > > > 
> > > > > > Excellent. This means defining a new signature type - the
> > > > > > two options seem to be Mikhail's portable format, or the
> > > > > > approach I took of having the signature define which
> > > > > > metadata is included. Do you have a preference?      
> > > > > 
> > > > > We now understand that as long as the EVM signature includes
> > > > > security.ima, it is safe not to include the i_ino/uuid.  This
> > > > > new format can be written to disk.    
> > > > 
> > > > But, isn't this mean we could have this scenario of offline
> > > > manipulations:
> > > > 1) store old file with xattrs;
> > > > 2) wait;
> > > > 3) replace new file with fixed exploits on old one.
> > > > 
> > > > Since we don't have directory tree protection yet and we don't
> > > > use i_ino, someone could reuse old files more easy during
> > > > offline manipulations. Right?    
> > > 
> > > As long as the new EVM signature format requires the existence of
> > > a security.ima xattr, I don't see how.  The new EVM signature
> > > format would not be replaced with an HMAC.  
> > 
> > 
> > I understood the idea.
> > 
> > Looks like portable EVM format support proposed by Matthew, could be
> > easy realized. Probably, will be good idea add only this one, test
> > it, and later add immutable EVM format and portable EVM format that
> > converted into HMAC (that I proposed in patch set)?
> > 
> > If no one ask for portable EVM format that converted into HMAC, do
> > we really need push all in one bunch?  
> 
> It looks like Dmitry already defined a new "immutable" EVM  signature
> format in ima-evm-utils and posted the corresponding patch to linux-
> ima-devel a long time ago.
> 
> The new "immutable" EVM signature doesn't include the i_ino or
> generation.

Yes. Btw, Dmitry's patch is the base of proposed by me "portable"
version support patch:
https://sourceforge.net/p/linux-ima/mailman/message/35587348/
since for portable format we use same idea - EVM signature format
without i_ino/generation/uuid.
Plus, that was the reason for keep for "portable" format
signature version number "3", since Dmitry already did all changes in
ima-evm-utils, portable format could be tested.

In the same time, I proposed "immutable" EVM signature, that
identically to current EVM digsig (with i_ino,...), but can't be
changed into HMAC. This patch don't related to Dmitry's "immutable" EVM
signature format support:
https://sourceforge.net/p/linux-ima/mailman/message/35601151/
I didn't really work on "immutable" EVM signature, only "portable"
version support needs was taken into account.

For now, we don't have ready for upstream "immutable" EVM signature
format support patch. Both, Dmitry's and my, patches need more work
in order to prevent file's data changes (in case of IMA hash) and
metadata changes for files signed by "immutable" EVM xattr (same idea
as we already have for IMA digsig, that prevent file's data change).


-- 
Best regards,
Mikhail Kurinnoi
