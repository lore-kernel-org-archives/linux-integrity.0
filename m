Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547263B9D9F
	for <linux-integrity@vger.kernel.org>; Tue,  8 Sep 2026 09:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788861491; cv=none; b=gvt3l2iKo0xRnwwTbkpTcd0x75hLhzCjF5ufiU1zUqKG2yFvuaxlKqnNYxbX5krj0A/yLCCuwgCI8WUpBAJuqzp2ys/53I/hIeQyipUEy6BtFzqu1NqLiHTL6hcBpLfufXjUTwGyqLsDAAaLLXu+rRRid94unCfZXOqCSNrM2pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788861491; c=relaxed/simple;
	bh=GFSj5qAy9vYn8+e5FLI9ZZSNUL41TFRXiLI+Y55Id4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hvONELPix/ssjRtdHjsBOpoTWXmpH75zFYQGtkkCdQPh7JEa7TisVcbHqMaFmaz/O6YeaDRwopoU3cA7eNZ/S3gGDW+rv+to6vaqExums4KFmpltq1cAIeelekjkEC8EluomgDXIUtr2Y34M5fk0pYkvVB5YH0wvJBopXVOcbmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E8iANauH; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="E8iANauH"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49b965570d7so51124035e9.0
        for <linux-integrity@vger.kernel.org>; Tue, 08 Sep 2026 02:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788861488; x=1789466288; darn=vger.kernel.org;
        h=user-agent:content-disposition:content-type:mime-version:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Aao+FhpXJHP+eq2jV1x2opJz/dMoQGT1F56qfGi/IdE=;
        b=E8iANauHpR9ckNwAdN4HJSC0HcgMyGkLROOt+HZadXpHir4CmMSRtGJP19Ic1po0Dz
         d+GiaBy+RcOjgvP4LfdLrFXw+0u/4Tpf2XxIQky8Zf5jymSenQ232mvQL3ZTPM5Vv8AF
         IvA+FXTaa5e70Q/NA6y5KnFrZ4Yg72h6sqqEmcUT68dpgeojA7xaXp7VHqm7dhGb0VWX
         2qs3fGDEcTHEOIqB1/gUkt4UYg321eY/OPpEyTGVjtH0hTPqV1YblVm5MrpIPayU/LA/
         msw1NZbhDq/okwI8QfYkJB2ZiyQiKp7khP/dz8Y78r1jsy6tSshZZZSbmbwCg8J6zqpM
         RTSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788861488; x=1789466288;
        h=user-agent:content-disposition:content-type:mime-version:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Aao+FhpXJHP+eq2jV1x2opJz/dMoQGT1F56qfGi/IdE=;
        b=Da029Fq6ybj3PNM4SWqrpCmqaHVqR4eLNU6DBKnQUgdBvaOeaUCG6bQOQP/JxNSF2D
         TRSjAIcbqP2BW6dPSSmUD7wgkalzFJIuaBOtC5crRI6xlkB8pz0PhsYF2aT+/Ysisx31
         ozmhLjPDQZafv/bTN5TWaq/SAXm0TAK3IyCtSGY+YXCMFXySXvTB0UDeX7YptL+3WboF
         9NXyTvDReLTUqKdFM76stAbKwAlWAh6asSsw384Tg8S3r7rD3ejfTJkgMcKx5mxzLT7A
         YqEd0NNF05golPBYNG8E+LpTbJDF8ew0Dc1HRBxF8dwHJ6EUwAaBmnHp/gASOXs3neh8
         Du1Q==
X-Forwarded-Encrypted: i=1; AKwUvBzRBc5A90HNCtvtUTMAx1kES6viyc3DSczS2RONd95Tac5S7SOfHZAYCa0xptuxHs0gvSwjTkwYZigC8TYWVQY=@vger.kernel.org
X-Gm-Message-State: AFuF++lVqjERyH7jHQV6EqVZxg0Hmx+Ps/Z1vhxYiiYi/TUdcOKMuGYM
	1ctoHvym0x5+aLHv/WA7FJuDV08soOr6VHrHkokWiY9BqD4uz0mjm0+w+RmEkNtLUPs=
X-Gm-Gg: AYBFou2eV6nhn+SkcobFt/2JSMc6m4VWgQt1AKvSMHW2zp86PBqDi1UMzUrssAHN3xu
	F7VbQiMQRYwFSHTuM6ZNn+VsYr5kOYww/DIbszvvnWS+zjR63/HsC/3eMzfYdWj9x+hGE19HPVk
	J/CxJnw9w49I+8HXQDticv2xLikfbmIggA7NcEC8rGyu2vIZdEDcOsKQLqZVRYheuXdJlHJTQ+e
	n+TTnjDd3z2NfYvxT3lPn9WSoPXAoe+x7lD5y8kcc4TZvpM7TPJ8QM2NOJ6LXxwj8QvrguuR9pr
	raFfCEETYCEGGF/5urCcuBkjFqGWcTrdqTxQUUX9BGHeYT0cq1fxeVsq7b81JgJF51NHil723C5
	FNuoJeQgZHZDqfRrfblIFSliMlh9FhmvPUbsu+sr01vap0jKHO6oAIrjxvR9L9JKHP1KBI4fPX9
	2mChrgTJTthQvhOvf4mH6EHbXvYccEq43GPxn3xcoMLc5eMVKrXO5QiWu+oFAttI+YtvMrmxPNe
	PgqqjvO1HSE7t4AjoPo+Ch/p/mF6SkCjjl39A8X9+tuhg==
X-Received: by 2002:a05:600d:864f:20b0:49c:fc6e:8cbd with SMTP id 5b1f17b1804b1-49cfc6e8ed8mr182108975e9.33.1788861488281;
        Tue, 08 Sep 2026 02:58:08 -0700 (PDT)
Received: from r1chard (1-164-89-44.dynamic-ip.hinet.net. [1.164.89.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db14841eaasm55744225ad.8.2026.09.08.02.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 02:58:07 -0700 (PDT)
Date: Tue, 8 Sep 2026 17:58:02 +0800
From: Richard Lyu <richard.lyu@suse.com>
To: peterhuewe@gmx.de, jarkko@kernel.org
Cc: jgg@ziepe.ca, fourier.thomas@gmail.com, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org, Richard Lyu <richard.lyu@suse.com>
Subject: [PATCH] tpm: Remove ineffective wmb() from tpm_pm_resume()
Message-ID: <20260908095748.78967-1-richard.lyu@suse.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.51.0
User-Agent: Mutt/2.2.16 (2025-11-22)

The comment above the wmb() in tpm_pm_resume() states that the barrier
guarantees TPM_CHIP_FLAG_SUSPENDED is written last, so that hwrng does
not activate before the chip has been fully resumed.  It cannot do so:
it is placed after the store that clears the flag, and therefore does
not order the preceding resume work before that store.  It also has
nothing to pair with, as tpm_try_get_ops() contains no matching read
barrier.

Drop the barrier along with the comment rather than leave a no-op
behind.  Should such ordering turn out to be needed, it would require
paired barriers or locking.

Fixes: 99d464506255 ("tpm: Prevent hwrng from activating during resume")
Link: https://lore.kernel.org/all/a62fc816-259a-4d28-a265-e425bc17ed50@gmail.com/
Signed-off-by: Richard Lyu <richard.lyu@suse.com>
---
 drivers/char/tpm/tpm-interface.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index b4e749e70b02..0bab78c8767c 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -497,12 +497,6 @@ int tpm_pm_resume(struct device *dev)
 
 	chip->flags &= ~TPM_CHIP_FLAG_SUSPENDED;
 
-	/*
-	 * Guarantee that SUSPENDED is written last, so that hwrng does not
-	 * activate before the chip has been fully resumed.
-	 */
-	wmb();
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(tpm_pm_resume);
-- 
2.51.0

