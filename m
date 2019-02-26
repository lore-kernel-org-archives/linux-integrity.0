Return-Path: <SRS0=XaU3=RB=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C55C10F0B
	for <linux-integrity@archiver.kernel.org>; Tue, 26 Feb 2019 21:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11E7521873
	for <linux-integrity@archiver.kernel.org>; Tue, 26 Feb 2019 21:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jqy8GDMd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbfBZVum (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 26 Feb 2019 16:50:42 -0500
Received: from mail-oi1-f201.google.com ([209.85.167.201]:38072 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728766AbfBZVum (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Feb 2019 16:50:42 -0500
Received: by mail-oi1-f201.google.com with SMTP id k22so1263878oih.5
        for <linux-integrity@vger.kernel.org>; Tue, 26 Feb 2019 13:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=lVrgxsy6HVfrp3Za5qPkXrG6BjzowrrJJ+yFXMH5lAs=;
        b=Jqy8GDMdZPSfsndndsLMvEQsz0au6nxpasdyzwiUQveqVNCgpPLXN01QBmBl2MWivz
         9Mex/Ze6TYyuZaB2AgZqKUah2aZg1OE5E/Ql88seM+Cvwa+A2E68HZrAiwUInFtZ5qFu
         Qpus7kTXhW8ErpqumNsYCdYoROmfez5UbWJptOK9Rf2zzqwVgvPoIMIg8DXICgb3rk2E
         2iheA3TLxUxJWnhG4RtCtwFXvsJ+z/Ii4UdJjsveAxGsbTXkYhoOSYQj8cfAN6zOlU5Z
         3yEyzDWQd+PCF6kvRYQ/vDeNOGj5Np0trH+kKHYJFScqMn7fqs0Ixab482JxZbN4cVrW
         XEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=lVrgxsy6HVfrp3Za5qPkXrG6BjzowrrJJ+yFXMH5lAs=;
        b=hc5QybVNLW0xTSdT96zy5h1i38yF/IT0BXpCuTrPLohcO4EiXgIsR0XWHpxXRtNTCT
         3dn+lyxTcJ6xTgTS9Vcj2emSmiyeKlvrMz4J5WUzMMJhkXxDvPiD/lELPVwHOuoR/TYq
         PIM4rXh2krEvXQJ5SC7nvnqxcEf7yXa7269m65umoivXDL5pFYIJ1+1BKv0kLHk4Oula
         PFph4p2nB49tCYeoRELhcs+/w+DblcvBSYClKku/BCBdwjayQeGQrV2I4OiOqXJ/ea8D
         5NpWFK1EAtMs4VqAonQueJbRKAp+M49QyOurI8GOhi+1ND54rfgIeM8ma6YmNwX5GTY6
         wT2A==
X-Gm-Message-State: AHQUAuZla6R7Tb3hOMwst/zwVSQeul7h0TvPX5zuUaSUOLPBLM/dqFqY
        mqvBhIav/WxOkQl3RIDJOEe25DOXj/5NKdzXrkuVJeIbjUvSyE/0MzP0EqdEuh5GtATtrvMrkYG
        zbui2gHZfN86BUwG2iKH2pC3oBl8shjJgRoZxDBcxKOBgAH7kSPs1XXkaBLEGhjLej3+rbaBdCn
        bHspWSkZUmaE31Bdg92OE=
X-Google-Smtp-Source: AHgI3IZVRMya65go+dRNLZvMd9ARMoO5ii3wkik6i/Yurj8yG1q3zfJ+lffZE/sAwluStBx5Wu1Oi42BAY9NkhJPSNtBiw==
X-Received: by 2002:a05:6830:1254:: with SMTP id s20mr42107otp.41.1551217840858;
 Tue, 26 Feb 2019 13:50:40 -0800 (PST)
Date:   Tue, 26 Feb 2019 13:50:30 -0800
Message-Id: <20190226215034.68772-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b-goog
Subject: Allow trusted filesystems to provide IMA hashes directly
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

When an IMA measurement is triggered, IMA is forced to read the entire
file and hash it. This can take a significant amount of time for large
files. If the filesystem has a secure mechanism for storing the file's
hash then it makes sense to allow the filesystem to simply return that
rather than forcing the entire file to be read.

This patchset adds an additional VFS call for providing the hash, and
teaches IMA how to use it. An additional parameter is added to the IMA
policy in order to indicate that a specific filesystem is trusted to
provide the hashes. Mounts that would otherwise match the policy but
which were mounted by a non-privileged user will still fall back to
reading the entire file to obtain the hash. Finally, a kernel parameter
is added to force hashes to be generated even if the policy says
otherwise.

This has been developed for FUSE, so the patchset includes some
additional supporting code. It adds an additional subtype parameter to
IMA policy to permit policy matching against specific FUSE filesystem
types. The expectation is that an LSM is used to restrict which
filesystems are able to mount with this subtype, preventing cases where
an untrusted FUSE filesystem is able to pretend to be a trusted one.

The use of FUSE (or any network filesystem) with IMA is already only
viable with specific security controls - an untrusted filesystem can
provide one set of data to the kernel when generating the initial
hashes, but a different set of data when the executable is actually run.
As a result, it's reasonable to assert that any setup relying on IMA
should already be imposing restrictions that ensure that FUSE
filesystems are only mounted by trustworthy executables. If this is the
case, there is no additional security concern raised by these patches.


