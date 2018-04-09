Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-lf0-f50.google.com ([209.85.215.50]:40527 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751291AbeDIOKN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Apr 2018 10:10:13 -0400
MIME-Version: 1.0
In-Reply-To: <1523277971.16421.189.camel@linux.vnet.ibm.com>
References: <CABatt_ytYORYKtApcB4izhNanEKkGFi9XAQMjHi_n-8YWoCRiw@mail.gmail.com>
 <1523277971.16421.189.camel@linux.vnet.ibm.com>
From: Martin Townsend <mtownsend1973@gmail.com>
Date: Mon, 9 Apr 2018 15:10:11 +0100
Message-ID: <CABatt_y9kVNit-Cyo0hFmrjgQMUqi6W1XkCkHxHMPaQeB4Ry8Q@mail.gmail.com>
Subject: Re: CAAM and IMA/EVM : caam_rsa_enc: DECO: desc idx 7: Protocol Size Error
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Mimi,

On Mon, Apr 9, 2018 at 1:46 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> On Mon, 2018-04-09 at 09:41 +0100, Martin Townsend wrote:
>> Hi,
>>
>> I'm trying to get to the bottom of an issue I'm seeing when enabling
>> the CAAM in the kernel with IMA/EVM enabled.  I'm using the official
>> NXP (imx_4.9.11_1.0.0_ga) vendor Kernel.
>>
>> Here's the error message I'm getting.
>>
>> caam_jr 2142000.jr1: 40000789: DECO: desc idx 7: Protocol Size Error -
>> A protocol has seen an error in size. When running RSA, pdb size N <
>> (size of F) when no formatting is used; or pdb size N < (F + 11) when
>> formatting is used.
>> integrity: Problem loading X.509 certificate (-129): /etc/keys/ima-x509.der
>
> This error message indicates that the kernel is trying to load a key
> onto the IMA keyring, but any key added to the trusted IMA keyring
> (.ima) must be signed by a key on the builtin (or secondary) keyring.
>
> Please verify that the public key used to sign the ima-x509.der is on
> the builtin keyring (eg. "keyctl show %keyring:.builtin_trusted_keys)
> or the secondary keyring.  Depending on how the kernel was configured,
> loading the public CA onto the builtin (or secondary) keyring might be
> possible.
>
> Some distros are carrying patches which load the UEFI keys onto the
> secondary keyring.  The other (preferred) method would be to insert
> the CA certificate into the kernel and resign the kernel.  This
> requires reserving memory for the key when the kernel is built.
>
> CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
> CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=4096
>
> Mimi

I think the integrity error message is a side effect of the previous
error, ie we are getting this error message because the CAAM is
failing to verify the certificates signature and hence IMA fails to
load the certificate onto the keyring.  If I disable CAAM then
everything works as expected.  What I'm trying to get to the bottom of
is why CAAM is failing to verify the signature.  Further below in the
email I have determined that the signature is 257 bytes do you think
this is correct?  I've read a post here:
https://crypto.stackexchange.com/questions/3505/what-is-the-length-of-an-rsa-signature

That says that for PKCS#1 the signature should always be of the size
of the modulus, then it goes on to say: "In some protocols, there can
be some wrapping around the signature, e.g. to indicate which
algorithm was used,"  I'm wondering if that's what I'm seeing, an
extra byte in the signature that is the type of algorithm used but
this extra byte is also passed to the CAAM and causes it to fail as
then the signature is now larger than the modulus.  But I don't know
what I can do about this, I'm not even sure what protocol is being
used to generate this extra byte, any suggestions on how to find this
out would be appreciated.

>
>
>> I put a dump_stack in the error handling routine in CAAM and in the
>> caam_jr_enqueue to get (I removed some of the caam_jr_enqueue
>> dump_stacks during initialisation to highlight the one of interest)
>>
>> caam 2140000.caam: ERA source: CCBVID.
>> caam 2140000.caam: Entropy delay = 3200
>> caam 2140000.caam: Instantiated RNG4 SH0
>> caam 2140000.caam: Instantiated RNG4 SH1
>> caam 2140000.caam: device ID = 0x0a16030000000000 (Era 8)
>> caam 2140000.caam: job rings = 3, qi = 0
>> caam algorithms registered in /proc/crypto
>> caam_jr_enqueue
>> CPU: 0 PID: 1 Comm: swapper Not tainted 4.9.11-1.0.0+gc27010d #4
>> Hardware name: Freescale i.MX6 UltraLite (Device Tree)
>> caam_jr_enqueue
>> CPU: 0 PID: 1 Comm: swapper Not tainted 4.9.11-1.0.0+gc27010d #4
>> Hardware name: Freescale i.MX6 UltraLite (Device Tree)
>> caam_jr 2141000.jr0: registering rng-caam
>> caam 2140000.caam: caam pkc algorithms registered in /proc/crypto
>> caam_jr_enqueue
>> CPU: 0 PID: 1 Comm: swapper Not tainted 4.9.11-1.0.0+gc27010d #4
>> Hardware name: Freescale i.MX6 UltraLite (Device Tree)
>> caam_rsa_set_pub_key
>> caam_rsa_max_size
>> caam_rsa_enc
>> caam_jr_enqueue
>> CPU: 0 PID: 1 Comm: swapper Not tainted 4.9.11-1.0.0+gc27010d #4
>> Hardware name: Freescale i.MX6 UltraLite (Device Tree)
>> [<8010dd8c>] (unwind_backtrace) from [<8010b8cc>] (show_stack+0x10/0x14)
>> [<8010b8cc>] (show_stack) from [<80608f74>] (caam_jr_enqueue+0x3c/0x2bc)
>> [<80608f74>] (caam_jr_enqueue) from [<8061fb84>] (caam_rsa_enc+0x210/0x3ac)
>> [<8061fb84>] (caam_rsa_enc) from [<803ed910>] (pkcs1pad_verify+0xa8/0xe4)
>> [<803ed910>] (pkcs1pad_verify) from [<804134e4>]
>> (public_key_verify_signature+0x17c/0x248)
>> [<804134e4>] (public_key_verify_signature) from [<804132a0>]
>> (restrict_link_by_signature+0xa8/0xd4)
>> [<804132a0>] (restrict_link_by_signature) from [<803cadd4>]
>> (key_create_or_update+0x12c/0x370)
>> [<803cadd4>] (key_create_or_update) from [<80c253a0>]
>> (integrity_load_x509+0x70/0xc4)
>> [<80c253a0>] (integrity_load_x509) from [<80c256bc>] (ima_load_x509+0x28/0x3c)
>> [<80c256bc>] (ima_load_x509) from [<80c2510c>] (integrity_load_keys+0x8/0x10)
>> [<80c2510c>] (integrity_load_keys) from [<80c00de0>]
>> (kernel_init_freeable+0x1bc/0x1cc)
>> [<80c00de0>] (kernel_init_freeable) from [<80844ccc>] (kernel_init+0x8/0x114)
>> [<80844ccc>] (kernel_init) from [<801078d8>] (ret_from_fork+0x14/0x3c)
>> CPU: 0 PID: 112 Comm: irq/214-2142000 Not tainted 4.9.11-1.0.0+gc27010d #4
>> Hardware name: Freescale i.MX6 UltraLite (Device Tree)
>> [<8010dd8c>] (unwind_backtrace) from [<8010b8cc>] (show_stack+0x10/0x14)
>> [<8010b8cc>] (show_stack) from [<8060a0e8>] (report_deco_status+0x30/0xf8)
>> [<8060a0e8>] (report_deco_status) from [<8061f3c8>] (rsa_pub_done+0x20/0x60)
>> [<8061f3c8>] (rsa_pub_done) from [<80608d94>] (caam_jr_threadirq+0x1dc/0x29c)
>> [<80608d94>] (caam_jr_threadirq) from [<80165dcc>] (irq_thread_fn+0x1c/0x54)
>> [<80165dcc>] (irq_thread_fn) from [<80166024>] (irq_thread+0x114/0x1d4)
>> [<80166024>] (irq_thread) from [<801415b4>] (kthread+0xe4/0xec)
>> [<801415b4>] (kthread) from [<801078d8>] (ret_from_fork+0x14/0x3c)
>> caam_jr 2142000.jr1: 40000789: DECO: desc idx 7: Protocol Size Error -
>> A protocol has seen an error in size. When running RSA, pdb size N <
>> (size of F) when no formatting is used; or pdb size N < (F + 11) when
>> formatting is used.
>> integrity: Problem loading X.509 certificate (-129): /etc/keys/ima-x509.der
>> [<8010dd8c>] (unwind_backtrace) from [<8010b8cc>] (show_stack+0x10/0x14)
>> [<8010b8cc>] (show_stack) from [<8060a0d0>] (report_deco_status+0x30/0xf8)
>> [<8060a0d0>] (report_deco_status) from [<8061db94>] (rsa_pub_done+0x20/0x60)
>> [<8061db94>] (rsa_pub_done) from [<80608d94>] (caam_jr_threadirq+0x1dc/0x29c)
>> [<80608d94>] (caam_jr_threadirq) from [<80165dcc>] (irq_thread_fn+0x1c/0x54)
>> [<80165dcc>] (irq_thread_fn) from [<80166024>] (irq_thread+0x114/0x1d4)
>> [<80166024>] (irq_thread) from [<801415b4>] (kthread+0xe4/0xec)
>> [<801415b4>] (kthread) from [<801078d8>] (ret_from_fork+0x14/0x3c)
>>
>> So it's failing to verify the signature on my x509 certificate because
>> pdb size M < (size of F) ...
>>
>> On the NXP mailing lists there is someone with a similar issue and the
>> response was
>> "The error appears to be saying that the public RSA modulus is shorter
>> than the signature being verified.
>>
>> RSA uses modular arithmetic, and all valid values are smaller than the
>> public RSA modulus. However, the signature (F in the error message
>> below), is too large.
>>
>> The customer should try to determine why their public RSA Modulus (N)
>> is shorter than the signature (F)."
>>
>> I have to admit I'm not really sure what this means, I've created my
>> certificate using openssl and a configuration file (shown below) that
>> set the keysize to 2048 bits so I'm not sure how the signature in the
>> x509 is greater than the RSA modulus which in my limited understanding
>> is the key size in bits.
>>
>> I added the following to public_key_verify_signature()
>>
>> printk("%s: Public Key: Keylen: %u\n", __func__, pkey->keylen);
>> printk("%s: Signature: %u\n", __func__, sig->s_size);
>>
>> and get
>>
>> public_key_verify_signature: Public Key: Keylen: 270
>> public_key_verify_signature: Signature: 257
>>
>> I'm assuming they are both in bytes which kind of suggests the key
>> length is larger than the signature but then again this keylen may
>> include other information.  I'm a bit suspicious of the signature
>> length of 257 maybe this is causing the problem which could point to
>> creating the certificate incorrectly??  Here's the configuration I'm
>> using for the root cert:
>> [ ca ]
>> default_ca                      = CA_default
>>
>> [ CA_default ]
>> dir                             = ./ca
>>
>> certs                           = $dir/certsdb                  #
>> Where the issued certs are kept
>> new_certs_dir                   = $certs                        #
>> default place for new certs.
>> database                        = $dir/certdbindex.txt          #
>> database index file.
>> certificate                     = $dir/certs/ima-local-ca.x509  # The
>> CA certificate
>> private_key                     = $dir/private/ca-privkey.pem   # The
>> private key
>> default_days                    = 3650
>> default_md                      = sha256
>> preserve                        = no
>> email_in_dn                     = no
>> nameopt                         = default_ca
>> certopt                         = default_ca
>> policy                          = policy_ima_ca
>>
>> [ policy_ima_ca ]
>> countryName                     = match                   # Must be
>> the same as the CA
>> stateOrProvinceName             = match                   # Must be
>> the same as the CA
>> organizationName                = supplied
>> organizationalUnitName          = optional
>> commonName                      = supplied                # Must be there
>> emailAddress                    = optional
>>
>> [ req ]
>> default_bits                    = 2048                    # Size of keys
>> default_keyfile                 = privkey.pem             # name of
>> generated keys
>> string_mask                     = utf8only                # permitted characters
>> distinguished_name              = req_distinguished_name  # where to
>> get DN for reqs
>> prompt                          = no                      # No prompting
>> x509_extensions                 = v3_ca                   # The
>> extentions to add to self signed certs
>> req_extensions                  = v3_req                  # The
>> extensions to add to req's
>>
>> [ req_distinguished_name ]
>> O                               = xxx
>> OU                              = IMA
>> CN                              = xxx IMA-EVM Root CA
>> emailAddress                    = ca-ima-evm@xxx.com
>> L                               = xxx
>> ST                              = Dorset
>> C                               = xxx
>>
>> [ v3_ca ]
>> basicConstraints                = CA:TRUE
>> subjectKeyIdentifier            = hash
>> authorityKeyIdentifier          = keyid:always,issuer:always
>> subjectAltName                  = email:move
>>
>> [ v3_req ]
>> subjectAltName=email:move
>>
>>
>> Then the openssl (1.0.2n  7 Dec 2017) command to create the self
>> signed root CA certificate.
>>
>> openssl req -new -x509 -utf8 -sha256 \
>>             -days $((365 * $duration)) \
>>             -passout file:$rootcadir/private/key_pass.txt \
>>             -keyout $rootca_privkey \
>>             -outform DER \
>>             -out $rootca_pubcert_der \
>>             -config $rootcadir/$ima_root_openssl_cnf
>>
>> I'm not sure what I can do further to debug this so any help or
>> suggestions would be really appreciated.  If there is any further
>> debug that would help let me know and I'll try it out.
>>
>> Many Thanks,
>> Martin.
>>
>
