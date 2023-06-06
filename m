Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04033C7EE37
	for <linux-integrity@archiver.kernel.org>; Tue,  6 Jun 2023 21:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbjFFVSd (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 6 Jun 2023 17:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbjFFVSc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Jun 2023 17:18:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52801721;
        Tue,  6 Jun 2023 14:18:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5171360EC6;
        Tue,  6 Jun 2023 21:18:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB1FC433EF;
        Tue,  6 Jun 2023 21:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686086310;
        bh=rT39aEK+K3uR/3XOlMbDe04K7/U0xWVuxq8MDWQpi0M=;
        h=Date:Subject:From:To:References:In-Reply-To:From;
        b=g2akhLf2/i3GQvLNA6LIHI6z/A309fzZyqJ6vk/V2PSHeeiyYmt442fS7BKnWphFC
         mZMZJzH4VqYqIz/hwAyYG+JaBldGqzWitLb9NcUQO9Xku2/XmgTGNI0oeFwoc5oqws
         hQIfP/TZyKJYho5GmyCyVq4HBMHLtWU7h/5pMFRKqPq0dGH8dh9XTDGFc2ZD3HaEZn
         0PoJrq5qPmJ7vp84equjzrHFJ7V2iUE5cykVWSYG8Nuopiy020vZrphcEu4FEnBeKK
         8fO+jaFPfjEoEePDqmttF1QMjKoVP1TXxXXOFfBJHgR0zo/uuUSUgvGMis8eTJ64EP
         0vrG3s6Y4lgvA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 07 Jun 2023 00:18:27 +0300
Message-Id: <CT5VPOKQSXIJ.3560NHSPF6A4E@suppilovahvero>
Subject: Re: [PATCH v2 3/4] tpm_tis: Use responseRetry to recover from data
 transfer errors
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Alexander Steffen" <Alexander.Steffen@infineon.com>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230605175959.2131-1-Alexander.Steffen@infineon.com>
 <20230605175959.2131-4-Alexander.Steffen@infineon.com>
In-Reply-To: <20230605175959.2131-4-Alexander.Steffen@infineon.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon Jun 5, 2023 at 8:59 PM EEST, Alexander Steffen wrote:
> +static int tpm_tis_recv_with_retries(struct tpm_chip *chip, u8 *buf, siz=
e_t count)
> +{
> +	struct tpm_tis_data *priv =3D dev_get_drvdata(&chip->dev);
> +	unsigned int try;
> +	int rc =3D 0;
> +
> +	if (count < TPM_HEADER_SIZE) {
> +		rc =3D -EIO;
> +		goto out;
> +	}

	if (count < TPM_HEADER_SIZE)
		return -EIO;

BR, Jarkko
