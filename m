Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54664 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751439AbdJTP26 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Oct 2017 11:28:58 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4AA4FABBC
        for <linux-integrity@vger.kernel.org>; Fri, 20 Oct 2017 15:28:57 +0000 (UTC)
Date: Fri, 20 Oct 2017 17:28:53 +0200
From: Matthias Gerstner <mgerstner@suse.de>
To: linux-integrity@vger.kernel.org
Subject: Behaviour regarding scripts when enforcing digital signatures
Message-ID: <20171020152853.v3vzemp2t54ljgwg@f195.suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="4qo7emyuyy6pjpbt"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi,

I'm currently experimenting with enforcing digital signatures for all
root owned files and all files executed by root.

To achieve this I've created appropriate digital signatures in the
security.ima attribute for all relevant files and loaded a policy like
this:

    [default dont_appraise/dont_measure lines]
    appraise func=BPRM_CHECK fowner=0 appraise_type=imasig
    appraise func=FILE_MMAP fowner=0 mask=MAY_EXEC appraise_type=imasig
    appraise func=MODULE_CHECK appraise_type=imasig
    appraise func=FIRMWARE_CHECK appraise_type=imasig

This works fine so far and any files without a correct signature cannot
be executed any more.

There is one issue with scripts, however. In practice scripts can
always be executed even if they don't have digital signatures when they
are passed explicitly to the interpreter like:

    /bin/bash /root/my_unsigned_script.sh

However, when executed implicitly via the shebang line, the execution
will be prevented:

    $ /root/my_unsigned_script.sh
    -bash: /root/my_unsigned_script.sh: Permission denied

I can see that preventing execution of unsigned scripts is difficult to
achieve. However I'd like to make it possible to run scripts the usual
way at least, without having to sign them or passing them to the
interpeter explicitly. This way system administrators can write and
handle custom scripts the way they are used to.

As far as I see it, allowing this is not possible at the moment given
the currently available policy grammar. Can you confirm this?

Would it be possible to add this as a feature? I think the
func=BPRM_CHECK could support an additional limiting condition.
Something like:

    appraise func=BPRM_CHECK fowner=0 appraise_type=imasig permit_scripts

The code on the kernel side looks not like it would easily allow this,
though. In search_binary_handler() the call to security_bprm_check() is
made before we know which binfmt handler applies and whether we're
dealing with a script. Maybe somebody does have additional thoughts on
this anyways.

Another question on a related topic: Is it possible to enforce a minimum
key length and digest algorithm for signatures?

I will be happy for any input!

Regards

Matthias

-- 
Matthias Gerstner <matthias.gerstner@suse.de>
Dipl.-Wirtsch.-Inf. (FH), Security Engineer
https://www.suse.com/security
Telefon: +49 911 740 53 290
GPG Key ID: 0x14C405C971923553

SUSE Linux GmbH
GF: Felix Imendorffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nuernberg)


    [ Part 2, "Digital signature"  Application/PGP-SIGNATURE (Name: ]
    [ "signature.asc") 836 bytes. ]
    [ Unable to print this part. ]
